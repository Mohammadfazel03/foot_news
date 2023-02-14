import 'package:dio/dio.dart';

class MatchesApiService {
  final Dio _dio;

  MatchesApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getAllMatch(String date) async {
    final parameter = {
      "date": date,
    };
    return _dio.get('matches', queryParameters: parameter);
  }
}
