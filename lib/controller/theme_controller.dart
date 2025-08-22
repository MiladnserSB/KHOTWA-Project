import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  final lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
  );

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void toggleTheme(bool isDark) {
    isDarkMode.value = isDark;
    _saveTheme();
  }

  void _saveTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isDarkMode', isDarkMode.value);
    } catch (e) {
      print("Error saving theme: $e");
    }
  }

  void _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    } catch (e) {
      print("Error loading theme: $e");
    }
  }
}
