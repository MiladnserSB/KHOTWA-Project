import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/login/terms_dialogue.dart';

class LoginTermsRow extends StatelessWidget {
  const LoginTermsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.checkOur,
          style: TextStyle(
            color: Colors.grey,
            fontSize: size.width * 0.04,
            shadows: [
              Shadow(
                color: Colors.black.withAlpha(80),
                offset: const Offset(0.2, 2.2),
                blurRadius: 7.0,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => const TermsDialog(),
          ),
          child: Text(
            AppStrings.termsPolicy,
            style: TextStyle(
              color: secondaryColor,
              fontSize: size.width * 0.04,
              shadows: [
                Shadow(
                  color: Colors.black.withAlpha(80),
                  offset: const Offset(0.2, 2.2),
                  blurRadius: 7.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
