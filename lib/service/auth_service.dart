import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:khotwa/model/login_model.dart';
import 'package:khotwa/shared/constants/base_url.dart';

class AuthService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<LoginModel?> signIn(String email, String password) async {
    try {
      final response = await dio.post('auth/login', data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 403) {
        throw Exception("verify_required");
      }

      return LoginModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final response = await dio.post('/auth/verify-otp', data: {
        "email": email,
        "otp": otp,
      });

      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Email verification failed");
    }
  }

  Future<bool> changeDefaultPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final box = Hive.box('authBox');
      final token = box.get('token');

      final response = await dio.post(
        '/volunteer/change-default-password',
        data: {
          "new_password": newPassword,
          "new_password_confirmation": confirmPassword,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception("Failed to change password: ${e.toString()}");
    }
  }


  Future<void> sendResetCode(String email) async {
  try {
    final response = await dio.post(
      '/auth/forget-password',
      data: {
        "email": email,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic Og==',
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send reset code');
    }
  } on DioException catch (e) {
    throw Exception(e.response?.data['message'] ?? 'An error occurred while sending the code');
  }
}
Future<bool> resetPassword({
  required String email,
  required String otp,
  required String password,
  required String passwordConfirmation,
}) async {
  try {
    final response = await dio.post(
      '/auth/confirm-reset-password',
      data: {
        "email": email,
        "otp": otp,
        "password": password,
        "password_confirmation": passwordConfirmation,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic Og==',
        },
      ),
    );

    return response.statusCode == 200;
  } catch (e) {
    throw Exception("Failed to confirm password reset: ${e.toString()}");
  }
}



}
