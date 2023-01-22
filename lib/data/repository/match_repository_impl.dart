import 'dart:convert';

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
    // TODO: implement getStreamMatches
    throw UnimplementedError();
  }

  @override
  Future<int> insertMatches(MatchResponse matches) {
    // TODO: implement insertMatches
    throw UnimplementedError();
  }

}