import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class DonateApologizeButton extends StatelessWidget {
  const DonateApologizeButton({
    super.key, required this.title, this.onTap,
  });
final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.45,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: secondaryColor,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
