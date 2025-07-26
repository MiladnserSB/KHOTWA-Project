import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/auth_controller.dart';
import 'package:khotwa/shared/constants/app_routes.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/verify_email/otp_input_section.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';
import 'package:khotwa/widgets/login_verify_change_hero_section.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final info = Get.arguments as Map<String, dynamic>? ?? {};
    final userEmail = info['email'] ?? '';
    final cameFromForgotPassword = info['cameFromForgotPassword'] ?? false;
    final screenSize = MediaQuery.of(context).size;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!auth.isEmailDialogShown) {
        showEmailSendDialouge(context, userEmail, screenSize);
        auth.isEmailDialogShown = true;
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, dims) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: dims.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenSize.height * 0.05),
                      LoginVerifyChangeLogo(
                        size: screenSize,
                        title: AppStrings.emailVerification,
                      ),
                      SizedBox(height: screenSize.height * 0.04),
                      OtpInputSection(
                        size: screenSize,
                        onSubmit: (code) {
                          auth.otp.value = code;
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.weAreAlmostThere,
                            style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: screenSize.width * 0.06,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.stairs_outlined,
                            color: secondaryColor,
                            size: screenSize.width * 0.065,
                          ),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.1),
                      AuthCustomButton(
                        title: AppStrings.verify,
                        onPressed: () {
                          final otpCode = auth.otp.value;

                          if (cameFromForgotPassword) {
                            auth.verifyEmailWithOtp(userEmail, otpCode);
                          } else {
                            Get.toNamed(
                              AppRoutes.changePassword,
                              arguments: {
                                'email': userEmail,
                                'otp': otpCode,
                                'authController.otp.value': otpCode,
                              },
                            );
                          }
                        },
                      ),
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

  void showEmailSendDialouge(BuildContext context, String email, Size dim) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Check Your Email Please!'),
        content: Text(
          'A code was sent to $email.\nPlease open your inbox and enter it where needed.',
          style: TextStyle(fontSize: dim.width * 0.04),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
