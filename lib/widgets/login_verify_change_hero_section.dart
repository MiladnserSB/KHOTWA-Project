import 'package:flutter/material.dart';

class LoginVerifyChangeLogo extends StatelessWidget {
  final Size size;
  final String title;
  const LoginVerifyChangeLogo({super.key, required this.size, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: size.width * 0.17,
          backgroundImage: const AssetImage('assets/images/logo1.png'),
        ),
        SizedBox(height: size.height * 0.04),
        Text(
          title,
          style: TextStyle(
            fontSize: size.width * 0.065,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
