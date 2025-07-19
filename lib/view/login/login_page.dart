import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/view/login/login_form.dart';
import 'package:khotwa/view/login/login_terms_row.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';
import 'package:khotwa/widgets/login_verify_change_hero_section.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                      LoginVerifyChangeLogo(size: size, title: AppStrings.signinaccount,),
                      SizedBox(height: size.height * 0.06),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: LoginForm(size: size),
                      ),
                      SizedBox(height: size.height * 0.04),
                      AuthCustomButton(title: AppStrings.signIn, onPressed: (){},),
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