
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';

class SubmitButton extends StatelessWidget {
  final double fontScale;
  final VoidCallback onPressed;

  const SubmitButton({
    super.key,
    required this.fontScale,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50 * fontScale,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.send, color: white),
        label: Text(
          "Submit Feedback".tr,
          style: TextStyle(
            fontSize: 16 * fontScale,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
