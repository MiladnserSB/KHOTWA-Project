import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';


enum SnackbarType { success, error, info, warning }

class CustomSnackbar {
  static void show({
    required SnackbarType type,
    required String title,
    required String message,
  }) {
    // Select colors and icons based on type
    Color bgColor;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        bgColor = primaryColor;
        icon = Icons.check_circle;
        break;
      case SnackbarType.error:
        bgColor = Colors.red.shade700;
        icon = Icons.error;
        break;
      case SnackbarType.info:
        bgColor = secondaryColor;
        icon = Icons.info;
        break;
      case SnackbarType.warning:
        bgColor = Colors.orange.shade800;
        icon = Icons.warning_amber_rounded;
        break;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: bgColor,
      colorText: white,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: Icon(
        icon,
        color: white,
        size: 28,
      ),
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: white,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          color: white,
        ),
      ),
    );
  }
}
