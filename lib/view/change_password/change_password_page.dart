import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/change_password/change_password_form.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';
import 'package:khotwa/widgets/login_verify_change_hero_section.dart';


class ChangingPasswordPage extends StatelessWidget {
   ChangingPasswordPage({super.key});

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final padding = mediaQuery.size.width * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      LoginVerifyChangeLogo(
                        size: mediaQuery.size,
                        title: AppStrings.changePass,
                      ),
                      const SizedBox(height: 36),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                              fontSize: mediaQuery.size.width * 0.065
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.check_circle, color: secondaryColor),
                        ],
                      ),
                       SizedBox(height: mediaQuery.size.height * 0.075  ),

                      AuthCustomButton(
                        title: AppStrings.change,
                        onPressed: () {
                          // TODO: Implement change password logic
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
