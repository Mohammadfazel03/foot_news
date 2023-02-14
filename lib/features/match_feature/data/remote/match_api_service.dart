import 'package:dio/dio.dart';

class MatchApiService {
  final Dio _dio;

  MatchApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getMatch(int matchId) async {
    final parameter = {
      "matchId": matchId,
    };
    return _dio.get('matchDetails', queryParameters: parameter);
  }
}
