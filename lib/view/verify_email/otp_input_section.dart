import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';

class OtpInputSection extends StatelessWidget {
  final Size size;

  const OtpInputSection({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 5-digit label
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppStrings.enterThe5Digit,
            style: TextStyle(
              color: textBlack,
              fontSize: size.width * 0.038,
            ),
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
          textStyle: TextStyle(
            fontSize: size.width * 0.055,
            fontWeight: FontWeight.bold,
            color: textBlack,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onCodeChanged: (String code) {
            // optional: update state/UI as user types
          },
          onSubmit: (String verificationCode) {
            // handle OTP submission
            print("OTP Entered: $verificationCode");
          },
        ),
        SizedBox(height: size.height * 0.025),
        // Resend Code Text
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppStrings.dontRecieveCode,
              style: TextStyle(
                color: Colors.black54,
                fontSize: size.width * 0.035,
                shadows: [
                  Shadow(
                    color: Colors.black.withAlpha(80),
                    offset: Offset(0.2, 2.2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                // Handle resend logic
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
