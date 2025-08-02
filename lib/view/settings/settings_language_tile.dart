import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class SettingsLanguageTile extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onChanged;
  final bool isDark;

  const SettingsLanguageTile({
    super.key,
    required this.selectedLanguage,
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
      child: ListTile(
        title: Text("App Language", style: TextStyle(color: textColor)),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: tileColor,
            value: selectedLanguage,
            icon: Icon(Icons.keyboard_arrow_down, color: textColor),
            items: ['English', 'Arabic'].map((lang) {
              return DropdownMenuItem<String>(
                value: lang,
                child: Text(lang, style: TextStyle(color: textColor)),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) onChanged(value);
            },
          ),
        ),
      ),
    );
  }
}
