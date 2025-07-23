import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class AuthCustomButton extends StatelessWidget {
  const AuthCustomButton({super.key, required this.title, required this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width*0.75,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: secondaryColor
          ),
          child: Center(child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
        ),
      ),
    );
    
  }
}