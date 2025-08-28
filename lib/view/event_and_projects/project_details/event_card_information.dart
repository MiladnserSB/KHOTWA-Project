import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class EventCardInformation extends StatelessWidget {
  
  final IconData icon;
  final String title;
  final String value;
  final double fontScale;

  const EventCardInformation({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.fontScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
              final theme = Theme.of(context); 

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
              Icon(icon, color: primaryColor,
 size: 20),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(color: primaryColor, fontSize: 13 * fontScale)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 14 * fontScale,
            ),
          ),
        ],
      ),
    );
  }
}
