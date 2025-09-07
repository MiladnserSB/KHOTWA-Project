import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flag/flag.dart';
import 'package:khotwa/controller/Settings_Lang_Controller.dart';
import 'package:khotwa/controller/theme_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final themeController = Get.find<ThemeController>();
    final languageController = Get.find<SettingsLangController>();

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final bgColor = isDark ? Colors.black : Colors.white;
      final textColor = isDark ? Colors.white : Colors.black;

      return Scaffold(
        backgroundColor:
            theme.brightness == Brightness.dark ? Colors.black : thirdColor,
        appBar: AppBar(
          backgroundColor:
              theme.brightness == Brightness.dark ? primaryColor : secondaryColor,
          title: Text(
            'settings'.tr,
            style: TextStyle(
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: BackButton(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.03,
          ),
          children: [
            // Appearance section
            Text(
              "change mode".tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              activeColor: secondaryColor,
              value: isDark,
              onChanged: (val) {
                themeController.toggleTheme(val);
                Get.snackbar(
                  "Theme Changed".tr,
                  val ? "dark mode".tr : "light mode".tr,
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              title: Text(
                isDark ? "dark mode".tr : "light mode".tr,
                style: TextStyle(color: textColor),
              ),
              secondary: Icon(
                isDark ? Icons.nightlight_round : Icons.wb_sunny,
                color: textColor,
              ),
            ),
            const SizedBox(height: 30),

            // Language section
            Text(
              "change language".tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),

            Obx(() => DropdownButtonFormField2<String>(
                  value: languageController.locale.value.languageCode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: textColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                  ),
                  style: TextStyle(color: textColor, fontSize: 14),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      languageController.changeLanguage(newValue);

                      String langLabel =
                          newValue == 'en' ? 'english'.tr : 'arabic'.tr;Get.snackbar(
                        "Language Changed".tr,
                        langLabel,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  items: [
                    _buildLanguageItem(
                        "en", 'English'.tr, "GB", textColor), // 🇬🇧
                    _buildLanguageItem(
                        "ar", 'Arabic'.tr, "SA", textColor), // 🇸🇦
                  ],
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 350,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.brightness == Brightness.dark
                          ? primaryColor
                          : secondaryColor,
                    ),
                    elevation: 8,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 14),
                  ),
                  iconStyleData: IconStyleData(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconSize: 24,
                    iconEnabledColor: textColor,
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return [
                      _buildSelectedItem('English'.tr, "GB", textColor),
                      _buildSelectedItem('Arabic'.tr, "SA", textColor),
                    ];
                  },
                )),

            const SizedBox(height: 40),
            // App version
            Center(
              child: Text(
                "khotwa v1.0.0",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  DropdownMenuItem<String> _buildLanguageItem(
      String code, String label, String countryCode, Color textColor) {
    return DropdownMenuItem(
      value: code,
      child: Row(
        children: [
          Flag.fromString(
            countryCode,
            height: 20,
            width: 30,
            fit: BoxFit.fill,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: textColor, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedItem(String label, String countryCode, Color textColor) {
    return Row(
      children: [
        Flag.fromString(
          countryCode,
          height: 20,
          width: 30,
          fit: BoxFit.fill,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(color: textColor, fontSize: 14),
        ),
      ],
    );
  }
}