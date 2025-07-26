import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class RowInformation extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const RowInformation({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: color),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: textBlack,
            ),
          ),
        ),
      ],
    );
  }
}
