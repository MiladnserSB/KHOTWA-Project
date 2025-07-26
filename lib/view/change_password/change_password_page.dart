import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:khotwa/controller/auth_controller.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/change_password/change_password_form.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';
import 'package:khotwa/widgets/login_verify_change_hero_section.dart';

class ChangingPasswordPage extends StatelessWidget {
  ChangingPasswordPage({super.key});

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screen = MediaQuery.of(context);
    final horizontalPadding = screen.size.width * 0.07;
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String email = args['email'] ?? '';
    final String otp = args['otp'] ?? '';
    final bool cameFromForgotPassword = args['cameFromForgotPassword'] ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      LoginVerifyChangeLogo(
                        size: screen.size,
                        title: AppStrings.changePass,
                      ),

                      const SizedBox(height: 36),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ChangePasswordForm(
                          newPasswordController: newPasswordController,
                          confirmPasswordController: confirmPasswordController,
                        ),
                      ),
                      const SizedBox(height: 36),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.weAreDone,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: screen.size.width * 0.065,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.check_circle, color: secondaryColor),
                        ],
                      ),
                      SizedBox(height: screen.size.height * 0.075),
                      
                      AuthCustomButton(
                        title: AppStrings.change,
                        onPressed: () {
                          final newPass = newPasswordController.text.trim();
                          final confirmPass = confirmPasswordController.text.trim();
                          if (newPass.isEmpty || confirmPass.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "Please enter the new password and its confirmation.",
                            );
                            return;
                          }

                          if (newPass != confirmPass) {
                            Get.snackbar(
                              "Error",
                              "Passwords do not match.",
                            );
                            return;
                          }

                          final authController = Get.find<AuthController>();
                          if (cameFromForgotPassword) {
                            if (otp.isEmpty) {
                              Get.snackbar("Error", "OTP is missing.");
                              return;
                            }
                            authController.confirmResetPassword(
                              email: email,
                              otp: otp,
                              newPassword: newPass,
                              confirmPassword: confirmPass,
                            );
                          } else {
                            authController.changePassword(
                              newPass,
                              confirmPass,
                            );
                          }
                        },
                      ),
                      const Spacer(),
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
