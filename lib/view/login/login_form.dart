import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/view/login/forgot_password_dialogue.dart';


class LoginForm extends StatefulWidget {
  final Size size;
  const LoginForm({super.key, required this.size});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final width = widget.size.width;
    final height = widget.size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.email,
          style: TextStyle(fontSize: width * 0.042, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: height * 0.01),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
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
        SizedBox(height: height * 0.02),
        Text(
          AppStrings.password,
          style: TextStyle(fontSize: width * 0.042, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: height * 0.01),
        TextFormField(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: AppStrings.passwordHint,
            filled: true,
            fillColor: const Color(0xFFF5F6F4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
          ),
        ),
        SizedBox(height: height * 0.015),
        Align(
  alignment: Alignment.centerRight,
  child: GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (_) => ForgotPasswordDialogue(emailController: emailController),
      );
    },
    child: Text(
      AppStrings.forgotPassword,
      style: TextStyle(
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w600,
        fontSize: width * 0.035,
      ),
    ),
  ),
),

      ],
    );
  }
}