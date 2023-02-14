import 'package:dio/dio.dart';

Dio getDioConfiguration() {
  var options = BaseOptions(
    baseUrl: 'https://www.fotmob.com/api/',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  return Dio(options);
}
