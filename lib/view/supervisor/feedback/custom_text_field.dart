import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double fontScale;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.fontScale,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * fontScale, vertical: 4),
      decoration: BoxDecoration(
        color: white,
        border: Border.all(color: grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(fontSize: 14 * fontScale, color: textBlack),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 14 * fontScale, color: grey),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
