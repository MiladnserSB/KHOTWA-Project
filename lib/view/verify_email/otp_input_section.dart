import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/auth_controller.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';

class OtpInputSection extends StatelessWidget {
  final Size size;
  final Function(String) onSubmit;

   OtpInputSection({super.key, required this.size, required this.onSubmit});
AuthController authController= Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppStrings.enterThe5Digit,
            style: TextStyle(color: textBlack, fontSize: size.width * 0.038),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        OtpTextField(
          numberOfFields: 5,
          borderColor: Colors.transparent,
          focusedBorderColor: secondaryColor,
          showFieldAsBox: true,
          borderRadius: BorderRadius.circular(10),
          fieldWidth: size.width * 0.15,
          fieldHeight: size.width * 0.15,
          filled: true,
          fillColor: Colors.grey[300]!,
          cursorColor: secondaryColor,
          keyboardType: TextInputType.number,
          onSubmit: onSubmit,
        ),
        SizedBox(height: size.height * 0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppStrings.dontRecieveCode,
              style: TextStyle(color: Colors.black54, fontSize: size.width * 0.035),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                authController.loginBeforeOTP();
             },
              child: Text(
                AppStrings.resend,
                style: TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.038,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}