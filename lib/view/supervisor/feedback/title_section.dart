import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class TitleSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final double fontScale;

  const TitleSection({
    super.key,
    required this.icon,
    required this.title,
    required this.fontScale,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: secondaryColor, size: 18 * fontScale),
        SizedBox(width: 6 * fontScale),
        Text(
          title,
          style: TextStyle(
            fontSize: 14 * fontScale,
            fontWeight: FontWeight.w600,
            color: textBlack,
          ),
        ),
      ],
    );
  }
}