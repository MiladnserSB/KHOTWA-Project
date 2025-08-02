import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/settings/settings_language_tile.dart';
import 'package:khotwa/view/settings/settings_section_title.dart';
import 'package:khotwa/view/settings/settings_switch_tile.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkTheme = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkTheme ? textBlack : white;
    final textColor = isDarkTheme ? white : textBlack;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Settings',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05,
              vertical: constraints.maxHeight * 0.03,
            ),
            children: [
              const SettingsSectionTitle(title: "Appearance"),
              SettingsSwitchTile(
                isDarkTheme: isDarkTheme,
                onChanged: (val) {
                  setState(() => isDarkTheme = val);
                },
                isDark: isDarkTheme,
              ),
              const SizedBox(height: 30),
              const SettingsSectionTitle(title: "Language"),
              SettingsLanguageTile(
                selectedLanguage: selectedLanguage,
                onChanged: (lang) {
                  setState(() => selectedLanguage = lang);
                },
                isDark: isDarkTheme,
              ),
              const SizedBox(height: 40),
               Center(
                child: Text(
                  "Khotwa App v1.0.0",
                  style: TextStyle(
                    color: grey,
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
