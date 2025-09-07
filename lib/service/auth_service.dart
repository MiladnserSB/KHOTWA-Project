import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:khotwa/model/login_model.dart';
import 'package:khotwa/model/login_model_after_otp.dart';
import 'package:khotwa/shared/constants/base_url.dart';

class AuthService extends GetxService {
  late Dio dio;

  AuthService() {
    super.onInit();
    _initializeDio();
  }

  void _initializeDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onError: (error, handler) {
          print('Dio error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
    print("dio init correct");
  }

 Future<String> _getToken() async {
    final box = Hive.box('authBox');
    final token = box.get('token');
    return token ?? '';
  }
  Future<String> _getRoleId() async {
    final box = Hive.box('authBox');
    final role_id = box.get('role_id');
    return role_id ?? '';
  }
  Future<String> _getUserId() async {
    final box = Hive.box('authBox');
    final user_id = box.get('user_id');
    return user_id ?? '';
  }
   Future<String> _getOtp() async {
    final box = Hive.box('authBox');
    final user_id = box.get('otp');
    return user_id ?? '';
  }
  Future<Map<String, dynamic>> registerUser({
    required String username,
    required String email,
    required String password,
    required int roleId,
  }) async {
    try {
      final response = await dio.post(
        '/api/auth/register',
        data: {
          "username": username,
          "email": email,
          "password": password,
          "role_id": roleId,
        },
      );

      if (response.statusCode == 201) {
        return response.data;
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        throw Exception(response.data['message'] ?? 'Invalid input');
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to register user: ${e.response?.data ?? e.message}',
      );
    }
  }

  // ⛔ Sign-in services kept as they are (unchanged)
  Future<LoginModel?> signIn(String email, String password) async {
    try {
      print("object");
      final response = await dio.post(
        '/api/auth/login',
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

          print(response.data);
      if (response.statusCode == 200) {
             print("object2");
        return LoginModel.fromJson(response.data);
      } else if (response.statusCode == 403 &&
          response.data['status'] == 'unverified_email') {
        return LoginModel.fromJson(response.data);
        // will throw inside controller
      } else if(response.statusCode == 403 &&
          response.data['status'] == 'unverified_password'){
      return LoginModel.fromJson(response.data); // ✅ return instead of throw
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginModelAfterOTP?> signInAfterOTP(
      String email, String password) async {
    try {
      final response = await dio.post(
        '/api/auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 403) {
        throw Exception("verify_required");
      }
      return LoginModelAfterOTP.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final response = await dio.post(
        '/api/auth/verify-otp',
        data: {
          "email": email,
          "otp": otp,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        throw Exception(response.data['message'] ?? "Invalid OTP");
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Email verification failed: ${e.toString()}");
    }
  }

  Future<bool> changeDefaultPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final myToken = await _getToken();
      final response = await dio.post(
        '/api/volunteer/change-default-password',
        data: {
          "new_password": newPassword,
          "new_password_confirmation": confirmPassword,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        throw Exception(response.data['message'] ?? "Invalid password format");
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to change password: ${e.toString()}");
    }
  }

  Future<void> sendResetCode(String email) async {
    try {
      final response = await dio.post(
        '/api/auth/forget-password',
        data: {
          "email": email,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['message'] ?? 'Failed to send reset code');
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'An error occurred while sending code');
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
        '/api/auth/confirm-reset-password',
        data: {
          "email": email,
          "otp": otp,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400 || response.statusCode == 422) {
        throw Exception(response.data['message'] ?? "Invalid reset attempt");
      } else {
        throw Exception("Unexpected error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to confirm password reset: ${e.toString()}");
    }
  }
}
