import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:foot_news/data/local/collections/match_league_collection.dart';
import 'package:foot_news/data/remote/model/match_league.dart';
import 'package:foot_news/data/remote/model/match_response.dart';
import 'package:foot_news/data/repository/match_repository.dart';
import 'package:foot_news/utils/data_response.dart';
import 'package:isar/isar.dart';

import '../remote/api_service.dart';

class MatchRepositoryImpl extends MatchRepository {
  final ApiService api;
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
      return DataFailed(e.toString());
    }
  }

  @override
  Stream<List<MatchLeague>> getStreamMatches(DateTime date) {
    final query = isar.matchLeagueCollections
        .filter()
        .matches((q) =>
        q.timeBetween(
            DateTime(date.year, date.month, date.day),
            DateTime(date.year, date.month, date.day)
                .add(const Duration(days: 1))))
        .build();
    return query.watch().map(
            (event) =>
            event.map((e) => MatchLeague.fromCollection(e)).toList());
  }

  @override
  Future<dynamic> insertMatches(MatchResponse matches) async {
    final leagues = matches.leagues;
    if (leagues != null) {
      return isar.writeTxn(() async {
        for (var league in leagues) {
          var leagueCollection = await isar.matchLeagueCollections
              .filter()
              .leagueIdEqualTo(league.id)
              .and()
              .primaryIdEqualTo(league.primaryId)
              .findFirst();

          if (leagueCollection == null) {
            leagueCollection = league.toCollection;
            await isar.matchLeagueCollections.put(leagueCollection);
          }

          if (league.matches != null) {
            for (var element in league.matches!) {
              final matchCollection = element.toCollection;
              matchCollection.league.value = leagueCollection;
              await isar.matchCollections.put(matchCollection);
              await matchCollection.league.save();
            }
          }
        }
      });
    }
    return Future(() => null);
  }
}
