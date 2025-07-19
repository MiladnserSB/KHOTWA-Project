import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class AppTheme {
  static final Color textColor = textBlack; // Define your desired text color

  static final ThemeData light = ThemeData(
    fontFamily: 'Acumin', // Set your custom font family
    textTheme: TextTheme(
      // Set the same color for all text styles
      bodyLarge: TextStyle(color: textColor),
      bodyMedium: TextStyle(color: textColor),
      bodySmall: TextStyle(color: textColor),
      headlineLarge: TextStyle(color: textColor),
      headlineMedium: TextStyle(color: textColor),
      headlineSmall: TextStyle(color: textColor),
      displayLarge: TextStyle(color: textColor),
      displayMedium: TextStyle(color: textColor),
      displaySmall: TextStyle(color: textColor),
      titleLarge: TextStyle(color: textColor),
      titleMedium: TextStyle(color: textColor),
      titleSmall: TextStyle(color: textColor),
      labelLarge: TextStyle(color: textColor),
      labelMedium: TextStyle(color: textColor),
      labelSmall: TextStyle(color: textColor),
    ),
  );
}
