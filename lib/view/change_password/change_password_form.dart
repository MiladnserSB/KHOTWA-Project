import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/change_password/custom_text_form_field.dart';


class ChangePasswordForm extends StatefulWidget {
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  const ChangePasswordForm({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  bool showPassword1 = false;
  bool showPassword2 = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
                 
            AppStrings.newPass,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: textBlack,
              
            ),
            
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: widget.newPasswordController,
          hintText: '********',
          obscureText: !showPassword1,
          suffixIcon: IconButton(
            icon: Icon(
              showPassword1 ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFF0B2B20),
            ),
            onPressed: () => setState(() => showPassword1 = !showPassword1),
          ),
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppStrings.confirmNewPass,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: textBlack,
            ),
          ),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: widget.confirmPasswordController,
          hintText: '********',
          obscureText: !showPassword2,
          suffixIcon: IconButton(
            icon: Icon(
              showPassword2 ? Icons.visibility_off : Icons.visibility,
              color: const Color(0xFF0B2B20),
            ),
            onPressed: () => setState(() => showPassword2 = !showPassword2),
          ),
        ),
      ],
    );
  }
}
