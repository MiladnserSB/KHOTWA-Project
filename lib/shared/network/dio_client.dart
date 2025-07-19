import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient() : dio = Dio(_baseOptions);

  static BaseOptions get _baseOptions => BaseOptions(
        baseUrl: 'https://mockapi.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      );
}
