// controllers/auth_controller.dart
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:khotwa/model/login_model.dart';
import 'package:khotwa/service/auth_service.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();
  final RxBool isLoading = false.obs;

  final email = ''.obs;
  final password = ''.obs;

  Future<void> login() async {
    isLoading.value = true;
    try {
      final LoginResponse? response = await authService.signIn(email.value, password.value);

      if (response != null) {
        final box = Hive.box('authBox');
        await box.put('token', response.token);
        await box.put('user_type', 'volunteer');
        await box.put('user_name', response.user.name);

        Get.snackbar("Success", response.message);
        // Navigate to next screen
      }
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
