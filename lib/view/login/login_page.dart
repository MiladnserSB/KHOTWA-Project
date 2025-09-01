import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/auth_controller.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/login/login_form.dart';
import 'package:khotwa/view/login/login_terms_row.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Volunteer.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';
import 'package:khotwa/widgets/login_verify_change_hero_section.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark
          ? Colors.black
          : thirdColor,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      LoginVerifyChangeLogo(
                        size: size,
                        title:"Sign in your account".tr,
                        
                      ),
                      SizedBox(height: size.height * 0.06),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: LoginForm(size: size),
                      ),
                      SizedBox(height: size.height * 0.04),
                      Obx(
                        () => AuthCustomButton(
                          title: authController.isLoading.value
                              ? 'Logging in...'.tr
                              : "Sign in".tr,
                          onPressed: authController.isLoading.value
                              ? null
                              // ignore: unnecessary_null_comparison
                              : () => authController.otp.value != null
                                    ? authController.loginAfterOTP()
                                    : authController.loginBeforeOTP(),
                          // onPressed: (){Get.to(AnimatedBottomBarPageVolunteer());},
                        ),
                      ),
                      SizedBox(height: size.height * 0.14),
                      const LoginTermsRow(),
                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
