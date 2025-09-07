import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/auth_controller.dart';
import 'package:khotwa/shared/constants/app_routes.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/change_password/change_password_page.dart';
import 'package:khotwa/view/verify_email/otp_input_section.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';
import 'package:khotwa/widgets/login_verify_change_hero_section.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);

    final auth = Get.find<AuthController>();
    final info = Get.arguments as Map<String, dynamic>? ?? {};
    final userEmail = info['email'] ?? '';
    final cameFromForgotPassword = info['cameFromForgotPassword'] ?? false;
    final screenSize = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark ? Colors.black : thirdColor,

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
                        title: "EmailVerification".tr,
                        
                      ),
                     SizedBox(height: screenSize.height * 0.04),

// 🔹 Replace OtpInputSection with TextField
TextField(
  keyboardType: TextInputType.number,
  maxLength: 6, // optional, if OTP is 6 digits
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: screenSize.width * 0.06,
    color: secondaryColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 4, // spacing between digits
  ),
  cursorColor: secondaryColor,
  decoration: InputDecoration(
    counterText: "", // hide maxLength counter
    hintText: "Enter OTP".tr,
    hintStyle: TextStyle(
      color: secondaryColor.withOpacity(0.6),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondaryColor, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: secondaryColor, width: 2.5),
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: Colors.white, // or theme-based if needed
    contentPadding: EdgeInsets.symmetric(vertical: 14),
  ),
  onChanged: (code) {
    auth.otp.value = code;
  },
),

SizedBox(height: screenSize.height * 0.12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           "WeAreAlmostThere".tr,
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
                        title: "Verify".tr,
                        onPressed: () {
                          final otpCode = auth.otp.value;

                          if (cameFromForgotPassword) {
                            auth.otp.value = otpCode;
                            auth.verifyEmailWithOtp(userEmail,otpCode );
                          } else {
                            auth.verifyEmailWithOtp(userEmail,otpCode);
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
        title:  Text('Check Your Email Please!'.tr),
        content: Text(
          'A code was sent to @email.\nPlease open your inbox and enter it where needed.'
    .trParams({"email": email}),
          style: TextStyle(fontSize: dim.width * 0.04),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK'.tr,
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
