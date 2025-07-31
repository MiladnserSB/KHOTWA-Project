
import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/row_for_cards_inforamtion.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.size, this.elevation = 2});

  final Size size;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              'assets/images/Intro.png',
              height: size.height * 0.5,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Event Title Goes Here',
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acumin',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Active',
                    style: TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Column(
              children: const [
                RowForCardsInformation(
                  icon: Icons.calendar_today,
                  label: 'Start Date',
                  value: '16.04.2024',
                ),
                SizedBox(height: 8),
                RowForCardsInformation(
                  icon: Icons.location_on,
                  label: 'Location',
                  value: 'Kharkiv, Ukraine',
                ),
                SizedBox(height: 8),
                RowForCardsInformation(
                  icon: Icons.volunteer_activism,
                  label: 'Volunteers',
                  value: '150 / 200',
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
