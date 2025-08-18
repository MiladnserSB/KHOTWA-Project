import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class AttendanceButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color backgroundColor;
  final double height;
  final VoidCallback onPressed;

  const AttendanceButton({
    super.key,
    required this.label,
    this.icon,
    required this.backgroundColor,
    required this.height,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double fontScale = MediaQuery.of(context).size.width / 375;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, color: white, size: 20 * fontScale) : const SizedBox.shrink(),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 16 * fontScale,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
