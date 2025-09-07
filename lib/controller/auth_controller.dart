import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:khotwa/model/login_model.dart';
import 'package:khotwa/model/login_model_after_otp.dart';
import 'package:khotwa/service/auth_service.dart';
import 'package:khotwa/shared/constants/app_routes.dart';
import 'package:khotwa/shared/constants/base_url.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Donor.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Volunteer.dart';
import 'package:khotwa/view/change_password/change_password_page.dart';
import 'package:khotwa/view/intro/Splash_Screen.dart';
import 'package:khotwa/view/verify_email/verify_email_page.dart';
import 'package:khotwa/widgets/custom_snack_bar.dart';

class AuthController extends GetxController {
  final AuthService authService = AuthService();
  final RxBool isLoading = false.obs;
  final email = ''.obs;
  final password = ''.obs;
  final otp = ''.obs;
  var isEmailDialogShown = false;
final box = Hive.box('authBox');



  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required int roleId,
  }) async {
    try {
      isLoading(true);
      final result = await authService.registerUser(
        username: username,
        email: email,
        password: password,
        roleId: 4,
      );
      print("this is the user id after registerning : "+ result['user_id']);
      userID=result['user'][''];
      print(userID);
 Get.snackbar(
          'Success',
          result['message'] ?? 'Registered successfully Make sure to login',
        );
        await box.put('user_id', result['user']['user_id']);
        await box.put('role_id', result['user']['role_id']);
        Get.offAll(SplashScreen());

    } catch (e) {
      // Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }




Future<void> loginBeforeOTP() async {
  isLoading.value = true;
  try {
    final LoginModel? response =
        await authService.signIn(email.value, password.value);

    if (response == null) {
      throw Exception("Empty login response");
    }

    // save token
    if(response.token!=null){
    await box.put('token', response.token);
    token = response.token!;
    }
    // save user data
    if(response.user!=null){
    await box.put('user_id', response.user!.id);
    await box.put('role_id', response.user!.roleId);
      userID = response.user!.id;
    roleID = response.user!.roleId;
    }
  

    print("User $userID logged in with role $roleID and token $token");

     if (response.status == "unverified_password") {
      // 🔑 force password change
      Get.offAll(() => ChangingPasswordPage());
      CustomSnackbar.show(
        type: SnackbarType.warning,
        title: "Password Change Required",
        message: "You must change your default password before continuing.",
      );
    } else if (response.message == "Login successful") {
      // ✅ Navigate according to role
      if (roleID == 4) {
        Get.offAll(() => AnimatedBottomBarPageDonor());
      } else if (roleID == 3 || roleID == 2) {
        Get.offAll(() => AnimatedBottomBarPageVolunteer());
      } else {
        Get.offAll(() => SplashScreen());
      }
    } else {
      // requires verification
      Get.off(
        () => VerifyEmailPage(),
        arguments: {
          'email': email.value,
          'cameFromForgotPassword': false,
        },
      );
    }
  } catch (e) {
    if (e is DioException && e.response?.data != null) {
      try {
        final errorResponse = LoginModel.fromJson(e.response!.data);
        await box.put('token', errorResponse.token);
      } catch (_) {
        CustomSnackbar.show(
          type: SnackbarType.error,
          title: "Error",
          message: "Unexpected error format from server.",
        );
      }
    }
    if (e.toString().contains("verify_required")) {
      Get.off(
        () => VerifyEmailPage(),
        arguments: {
          'email': email.value,
          'cameFromForgotPassword': false,
        },
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
    print("here");
    try {
      final LoginModelAfterOTP? response = await authService.signInAfterOTP(email.value, password.value);
      if (response != null) {
        userID = response.user.id;
        roleID = response.user.roleId;
        if (roleID == 4) {
          Get.offAll(AnimatedBottomBarPageDonor());
        }
        Get.offAll(AnimatedBottomBarPageVolunteer());
      }
    } catch (e) {
      CustomSnackbar.show(type: SnackbarType.error, title: "Error", message: "Login failed: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyEmailWithOtp(String email, String otp) async {
    isLoading.value = true;
    try {
      final success = await authService.verifyOtp(email, otp);
      if (success) {
        CustomSnackbar.show(type: SnackbarType.success, title: "Verified", message: "Please change your password.");

        print("This user ${await box.get('role_id')} that has token: " +  await box.get('token') + " has veryified with otp: $otp");
        this.otp.value = otp;
        if(roleID==4)
        Get.offAll(AnimatedBottomBarPageDonor());
        else{
          Get.to(ChangingPasswordPage());
        }
      } else {
        CustomSnackbar.show(type: SnackbarType.error, title: "Failed", message: "The verification code is incorrect");
      }
    } catch (e) {
      CustomSnackbar.show(type: SnackbarType.error, title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword(String newPassword, String confirmPassword) async {
    isLoading.value = true;

    try {
      final success = await authService.changeDefaultPassword(newPassword: newPassword, confirmPassword: confirmPassword);
      if (success) {
        CustomSnackbar.show(type: SnackbarType.success, title: "Changed", message: "Password changed successfully");
        if(roleID==2 || roleID==3
        )
        Get.offAll(AnimatedBottomBarPageVolunteer());
      } else {
        CustomSnackbar.show(type: SnackbarType.error, title: "Failed", message: "Failed to change password");
      }
    } catch (e) {
      CustomSnackbar.show(type: SnackbarType.error, title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword(String email) async {
    isLoading.value = true;
    try {
      await authService.sendResetCode(email);
      Get.back();
      Get.toNamed(AppRoutes.verifyEmail, arguments: {'email': email, 'cameFromForgotPassword': true});
      CustomSnackbar.show(type: SnackbarType.info, title: "Done", message: "The code has been sent to your email");
    } catch (e) {
      CustomSnackbar.show(type: SnackbarType.error, title: "Error", message: e.toString());
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
        CustomSnackbar.show(type: SnackbarType.success, title: "Done", message: "Password changed successfully, please log in");
        Get.offAllNamed(AppRoutes.login);
      } else {
        CustomSnackbar.show(type: SnackbarType.error, title: "Failed", message: "Failed to confirm password change");
      }
    } catch (e) {
      CustomSnackbar.show(type: SnackbarType.error, title: "Error", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
