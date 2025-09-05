import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';

class ForgotPasswordDialogue extends StatelessWidget {
  final TextEditingController emailController;

  const ForgotPasswordDialogue({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return Dialog(
      backgroundColor: theme.brightness == Brightness.dark
                        ? sixth
                        : thirdColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 270, minHeight: height * 0.20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),

              Text(
                "enterYourEmailPlease".tr,
                style: TextStyle(
                  fontSize: width * 0.050,
                  fontWeight: FontWeight.bold,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.05),
          
                 Text(
                  "Email".tr,
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              
              SizedBox(height: height * 0.008),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required".tr;
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email".tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: AppStrings.emailHint,
                  filled: true,
                  fillColor: const Color(0xFFF5F6F4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              SizedBox(height: height * 0.05),
              Row(
                children: [
                  const Icon(Icons.warning_rounded, color: secondaryColor),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "We will send a recovery code to your email.".tr,
                      style: TextStyle(
                        fontSize: width * 0.030,
                        fontWeight: FontWeight.w400,
                         color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              AuthCustomButton(
                title:"send".tr,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
