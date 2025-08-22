import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLangController extends GetxController {
  var locale = const Locale('en', 'US').obs;

  @override
  void onInit() {
    super.onInit();
    _loadLocale();
  }

  void changeLanguage(String langCode) {
    Locale newLocale;
    switch (langCode) {
      case 'ar':
        newLocale = const Locale('ar', 'SA');
        break;
      case 'fr':
        newLocale = const Locale('fr', 'FR');
        break;
      case 'nl':
        newLocale = const Locale('nl', 'NL');
        break;
      case 'es':
        newLocale = const Locale('es', 'ES');
        break;
      default:
        newLocale = const Locale('en', 'US');
    }

    if (locale.value != newLocale) {
      locale.value = newLocale;
      Get.updateLocale(newLocale);
      _saveLocale(newLocale);
    }
  }

  void _saveLocale(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('languageCode', locale.languageCode);
      prefs.setString('countryCode', locale.countryCode ?? '');
    } catch (e) {
      print("Error saving locale: $e");
    }
  }

  void _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('languageCode');
      final countryCode = prefs.getString('countryCode');
      if (languageCode != null) {
        locale.value = Locale(languageCode, countryCode);
        Get.updateLocale(locale.value);
      }
    } catch (e) {
      print("Error loading locale: $e");
    }
  }
}
