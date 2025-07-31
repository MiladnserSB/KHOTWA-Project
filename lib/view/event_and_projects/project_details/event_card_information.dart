
import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class EventCardInformation extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const EventCardInformation({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: white, size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(color: white, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
