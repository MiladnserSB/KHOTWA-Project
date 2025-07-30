import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:khotwa/model/login_model.dart';
import 'package:khotwa/service/auth_service.dart';
import 'package:khotwa/shared/constants/app_routes.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();

  final RxBool isLoading = false.obs;
  final email = ''.obs;
  final password = ''.obs;
  final otp = ''.obs;
  var isEmailDialogShown = false;
        
  Future<void> login() async {
    isLoading.value = true;

 try {
      final LoginModel? response = await authService.signIn(email.value, password.value);

      if (response != null) {
        final box = Hive.box('authBox');
        await box.put('token', response.token);
        await box.put('user_type', 'volunteer');
        await box.put('user_name', response.email);

        Get.offAllNamed(AppRoutes.homeVolunteer);
      }
    }   catch (e) {
      if (e.toString().contains("verify_required")) {
        Get.toNamed(AppRoutes.verifyEmail, arguments: {
  'email': email.value,
  'cameFromForgotPassword': false,
});
        Get.snackbar("Verification Required", "A verification code has been sent to your email.");
      } else {
        Get.snackbar("Error", "Login failed: ${e.toString()}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyEmailWithOtp(String email, String otp) async {
    isLoading.value = true;

    try {
      final success = await authService.verifyOtp(email, otp);

      if (success) {
        Get.snackbar("Verified", "Please change your password.");
        Get.toNamed(AppRoutes.changePassword);
      } else {
        Get.snackbar("Failed", "The verification code is incorrect");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword(String newPassword, String confirmPassword) async {
    isLoading.value = true;

    try {
      final success = await authService.changeDefaultPassword(
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (success) {
        Get.snackbar("Changed", "Password changed successfully");
        Get.offAllNamed(AppRoutes.homeVolunteer);
      } else {
        Get.snackbar("Failed", "Failed to change password");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
  isLoading.value = true;
  try {
    await authService.sendResetCode(email);
    Get.back(); 
    Get.toNamed(AppRoutes.verifyEmail,arguments: {
  'email': email,
  'cameFromForgotPassword': true,
});
    Get.snackbar("Done", "The code has been sent to your email");
  } catch (e) {
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading.value = false;
  }
}
Future<void> confirmResetPassword({
  required String email,
  required String otp,
  required String newPassword,
  required String confirmPassword,
}) async {
  isLoading.value = true;

  try {
    final success = await authService.resetPassword(
      email: email,
      otp: otp,
      password: newPassword,
      passwordConfirmation: confirmPassword,
    );

    if (success) {
      Get.snackbar("Done", "Password changed successfully, please log in");
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.snackbar("Failed", "Failed to confirm password change");
    }
  } catch (e) {
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading.value = false;
  }
}

}
