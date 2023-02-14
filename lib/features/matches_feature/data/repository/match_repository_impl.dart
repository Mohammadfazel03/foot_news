import 'package:dio/dio.dart';
import 'package:foot_news/common/utils/data_response.dart';
import 'package:foot_news/features/matches_feature/data/entity/match_entity.dart';
import 'package:foot_news/features/matches_feature/data/entity/match_league_entity.dart';
import 'package:foot_news/features/matches_feature/data/local/collections/match_collection.dart';
import 'package:foot_news/features/matches_feature/data/local/collections/match_league_collection.dart';
import 'package:foot_news/features/matches_feature/data/remote/matches_api_service.dart';
import 'package:foot_news/features/matches_feature/data/remote/model/match_response.dart';
import 'package:foot_news/features/matches_feature/data/repository/match_repository.dart';
import 'package:isar/isar.dart';

class MatchRepositoryImpl extends MatchRepository {
  final MatchesApiService api;
  final Isar isar;

  MatchRepositoryImpl({required this.api, required this.isar});

  @override
  Future<DataResponse<MatchResponse>> getMatches(String date) async {
    try {
      Response response = await api.getAllMatch(date);
      if (response.statusCode == 200) {
        return DataSuccess(MatchResponse.fromJson(response.data));
      }
      return const DataFailed("some thing went wrong");
    } catch (e) {
      if (e is DioError) {
        return DataFailed(e.message);
      }
      return const DataFailed('some thing went wrong');
    }
  }

  @override
  Stream<List<MatchLeagueEntity>> getStreamMatches(
      {required DateTime date,
      bool byTime = false,
      bool byOngoing = false,
      bool byFavourite = false}) {
    final query = isar.matchCollections
        .filter()
        .timeBetween(DateTime(date.year, date.month, date.day),
            DateTime(date.year, date.month, date.day).add(const Duration(days: 1)))
        .optional(byOngoing, (q) => q.status((q) => q.ongoingEqualTo(true)))
        .optional(byFavourite, (q) => q.isFavouriteEqualTo(true))
        .optional(byTime, (q) => q.sortByTime())
        .build();

    return query.watch(fireImmediately: true).map((event) {
      var matches = event.map((e) => MatchEntity.fromCollection(e)).toList(growable: false);
      List<MatchLeagueEntity> leagues = [];
      if (byTime && matches.isNotEmpty) {
        leagues.add(MatchLeagueEntity(matches: matches));
      } else {
        List<int> leaguesId = [];
        for (int i = 0; i < matches.length; i++) {
          if (!leaguesId.contains(matches[i].leagueId)) {
            var matchLeague = MatchLeagueEntity.fromCollection(event[i].league.value!)
                .copyWith(matches: [matches[i]]);
            leagues.add(matchLeague);
            leaguesId.add(matches[i].leagueId!);
          } else {
            leagues
                .firstWhere((element) => element.id == matches[i].leagueId)
                .matches
                ?.add(matches[i]);
          }
        }
      }
      return leagues;
    });
  }

  @override
  Future<dynamic> insertMatches(MatchResponse matches) async {
    final leagues = matches.leagues;
    if (leagues != null) {
      return isar.writeTxn(() async {
        for (var league in leagues) {
          var leagueCollection =
              await isar.matchLeagueCollections.getByPrimaryIdLeagueId(league.primaryId, league.id);

          if (leagueCollection == null) {
            leagueCollection = league.toCollection;
            await isar.matchLeagueCollections.putByPrimaryIdLeagueId(leagueCollection);
          }

          if (league.matches != null) {
            for (var element in league.matches!) {
              final matchCollection = element.toCollection;
              final matchCollectionExist = await isar.matchCollections.getByMatchId(element.id!);
              matchCollection.league.value = leagueCollection;
              matchCollection.isFavourite = matchCollectionExist?.isFavourite ?? false;
              await isar.matchCollections.putByMatchId(matchCollection);
              await matchCollection.league.save();
            }
          }
        }
      });
    }
    return Future(() => null);
  }

  @override
  Future<int> toggleFavorite(MatchEntity matchEntity) {
    final collection = matchEntity.toCollection;
    collection.isFavourite = !collection.isFavourite;
    return isar.writeTxn(() async => await isar.matchCollections.putByMatchId(collection));
  }
}
