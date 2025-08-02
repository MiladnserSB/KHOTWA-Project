import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class SettingsSwitchTile extends StatelessWidget {
  final bool isDarkTheme;
  final Function(bool) onChanged;
  final bool isDark;

  const SettingsSwitchTile({
    super.key,
    required this.isDarkTheme,
    required this.onChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final tileColor = isDark
        ? primaryColor.withOpacity(0.3)
        : Colors.grey.shade100;
    final textColor = isDark ? white : textBlack;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SwitchListTile(
        activeColor: secondaryColor,
        inactiveThumbColor: grey,
        inactiveTrackColor: grey.withOpacity(0.3),
        title: Text("Dark Theme", style: TextStyle(color: textColor)),
        value: isDarkTheme,
        onChanged: onChanged,
      ),
    );
  }
}
