import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkTheme = false.obs;

  ThemeMode get themeMode =>
      isDarkTheme.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool value) {
    isDarkTheme.value = value;
  }
}
