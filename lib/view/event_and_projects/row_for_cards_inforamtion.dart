
import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class RowForCardsInformation extends StatelessWidget {
  const RowForCardsInformation({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: secondaryColor),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
