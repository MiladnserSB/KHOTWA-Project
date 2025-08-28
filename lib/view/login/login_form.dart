import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/auth_controller.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/view/login/forgot_password_dialogue.dart';

class LoginForm extends StatefulWidget {
  final Size size;

  const LoginForm({super.key, required this.size});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AuthController authController = Get.find();
  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = widget.size.width;
    final height = widget.size.height;

    return Form( 
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.email,
            style: TextStyle(fontSize: width * 0.042, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: height * 0.01),
          TextFormField(
            onChanged: (value) => authController.email.value = value,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email is required";
              }
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              if (!emailRegex.hasMatch(value)) {
                return "Enter a valid email";
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
          SizedBox(height: height * 0.02),
          Text(
            AppStrings.password,
            style: TextStyle(fontSize: width * 0.042, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: height * 0.01),
          TextFormField(
            onChanged: (value) => authController.password.value = value,
            obscureText: !isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
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
                onPressed: () => setState(() {
                  isPasswordVisible = !isPasswordVisible;
                }),
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
                  builder: (_) => ForgotPasswordDialogue(
                    emailController: TextEditingController(text: authController.email.value),
                  ),
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
      ),
    );
  }
}
