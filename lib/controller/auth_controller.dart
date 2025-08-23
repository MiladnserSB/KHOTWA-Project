import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:khotwa/model/login_model.dart';
import 'package:khotwa/model/login_model_after_otp.dart';
import 'package:khotwa/service/auth_service.dart';
import 'package:khotwa/shared/constants/app_routes.dart';
import 'package:khotwa/shared/constants/base_url.dart';
import 'package:khotwa/widgets/custom_snack_bar.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();

  final RxBool isLoading = false.obs;
  final email = ''.obs;
  final password = ''.obs;
  final otp = ''.obs;
  var isEmailDialogShown = false;

  Future<void> loginBeforeOTP() async {
    isLoading.value = true;

    try {
      final LoginModel? response = await authService.signIn(
        email.value,
        password.value,
      );

      final box = Hive.box('authBox');
      await box.put('token', response!.token);
      await box.put('user_name', response.email);
      await box.put('user_type', 'volunteer');

    } catch (e) {
      if (e is DioException && e.response?.data != null) {
        try {
          final errorResponse = LoginModel.fromJson(e.response!.data);
          final box = Hive.box('authBox');
          await box.put('token', errorResponse.token);
          await box.put('user_name', errorResponse.email);
          await box.put('user_type', 'volunteer');
        } catch (_) {
          CustomSnackbar.show(
            type: SnackbarType.error,
            title: "Error",
            message: "Unexpected error format from server.",
          );
        }
      }

      if (e.toString().contains("verify_required")) {
        Get.offNamed(
          AppRoutes.verifyEmail,
          arguments: {'email': email.value, 'cameFromForgotPassword': false},
        );
        CustomSnackbar.show(
          type: SnackbarType.info,
          title: "Verification Required",
          message: "A verification code has been sent to your email.",
        );
      } else {
        CustomSnackbar.show(
          type: SnackbarType.error,
          title: "Error",
          message: "Login failed: ${e.toString()}",
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginAfterOTP() async {
    isLoading.value = true;

    try {
      final LoginModelAfterOTP? response = await authService.signInAfterOTP(
        email.value,
        password.value,
      );

      if (response != null) {
        userID = response.user.id;
        roleID = response.user.roleId;
        Get.offAllNamed(AppRoutes.volunteerHome);
      }
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: "Error",
        message: "Login failed: ${e.toString()}",
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyEmailWithOtp(String email, String otp) async {
    isLoading.value = true;

    try {
      final success = await authService.verifyOtp(email, otp);

      if (success) {
        CustomSnackbar.show(
          type: SnackbarType.success,
          title: "Verified",
          message: "Please change your password.",
        );
        Get.toNamed(AppRoutes.changePassword);
      } else {
        CustomSnackbar.show(
          type: SnackbarType.error,
          title: "Failed",
          message: "The verification code is incorrect",
        );
      }
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: "Error",
        message: e.toString(),
      );
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
        CustomSnackbar.show(
          type: SnackbarType.success,
          title: "Changed",
          message: "Password changed successfully",
        );
        loginAfterOTP();
      } else {
        CustomSnackbar.show(
          type: SnackbarType.error,
          title: "Failed",
          message: "Failed to change password",
        );
      }
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: "Error",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    isLoading.value = true;
    try {
      await authService.sendResetCode(email);
      Get.back();
      Get.toNamed(
        AppRoutes.verifyEmail,
        arguments: {'email': email, 'cameFromForgotPassword': true},
      );
      CustomSnackbar.show(
        type: SnackbarType.info,
        title: "Done",
        message: "The code has been sent to your email",
      );
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: "Error",
        message: e.toString(),
      );
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
        CustomSnackbar.show(
          type: SnackbarType.success,
          title: "Done",
          message: "Password changed successfully, please log in",
        );
        Get.offAllNamed(AppRoutes.login);
      } else {
        CustomSnackbar.show(
          type: SnackbarType.error,
          title: "Failed",
          message: "Failed to confirm password change",
        );
      }
    } catch (e) {
      CustomSnackbar.show(
        type: SnackbarType.error,
        title: "Error",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
