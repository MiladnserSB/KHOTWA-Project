import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/verify_email/otp_input_section.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';
import 'package:khotwa/widgets/login_verify_change_hero_section.dart';


class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
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
                        title: AppStrings.emailVerification,
                      ),

                      SizedBox(height: size.height * 0.04),

                      OtpInputSection(size: size),

                      SizedBox(height: size.height * 0.12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.weAreAlmostThere,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.stairs_outlined,
                            color: secondaryColor,
                            size: size.width * 0.065,
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.1),

                      // Verify Button
                      AuthCustomButton(
                        title: AppStrings.verify,
                        onPressed: () {
                          // Handle verify
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
}
