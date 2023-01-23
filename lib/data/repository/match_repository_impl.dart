import 'dart:convert';

import 'package:foot_news/data/local/collections/match_collection.dart';
import 'package:foot_news/data/local/collections/match_league_collection.dart';
import 'package:foot_news/data/remote/model/match_league.dart';
import 'package:foot_news/data/remote/model/match_response.dart';
import 'package:foot_news/data/repository/match_repository.dart';
import 'package:foot_news/utils/data_response.dart';
import 'package:http/http.dart';
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
        return DataSuccess(MatchResponse.fromJson(
            jsonDecode(utf8.decode(response.bodyBytes))));
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
        .matches((q) => q.timeBetween(
            DateTime(date.year, date.month, date.day),
            DateTime(date.year, date.month, date.day)
                .add(const Duration(days: 1))))
        .build();
    return query.watch().map(
        (event) => event.map((e) => MatchLeague.fromCollection(e)).toList());
  }

  @override
  Future<dynamic> insertMatches(MatchResponse matches) {
    return isar.writeTxn(() async {
      // await isar.matchLeagueCollections.putAll((matches.leagues?.map((e) => e.toCollection))?.toList()??[]);
      matches.leagues?.forEach((element) async {
        await isar.matchCollections.putAll(
            (element.matches?.map((e) => e.toCollection).toList()) ?? []);
        await isar.matchLeagueCollections.put(element.toCollection);
        await element.toCollection.matches.save();
      });
    });
  }
}
