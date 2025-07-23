import 'package:dio/dio.dart';
import 'package:khotwa/model/login_model.dart';
import 'package:khotwa/shared/constants/base_url.dart';

class AuthService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  ));

  Future<LoginResponse?> signIn(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        "email": email,
        "password": password,
      });

      return LoginResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}