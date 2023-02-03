import 'package:dio/dio.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    var options = BaseOptions(
      baseUrl: 'https://www.fotmob.com/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);
  }

  Future<dynamic> getAllMatch(String date) async {
    final parameter = {
      "date": date,
    };
    return _dio.get('/matches', queryParameters: parameter);
  }
}
