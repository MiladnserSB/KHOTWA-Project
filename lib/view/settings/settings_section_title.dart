import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class SettingsSectionTitle extends StatelessWidget {
  final String title;

  const SettingsSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.04,
        fontWeight: FontWeight.bold,
        color: secondaryColor,
      ),
    );
  }
}
