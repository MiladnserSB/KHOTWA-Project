import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';

class WarningsPage extends StatelessWidget {
  WarningsPage({super.key});

  final List<Map<String, String>> warnings = [
    {
      "reason": "Missed campaign without notice",
      "supervisor": "Dr. Sarah Lee",
      "event": "Blood Donation Drive",
    },
    {
      "reason": "Late arrival",
      "supervisor": "John Carter",
      "event": "Health Awareness Campaign",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Text(
          "Warnings".tr,
          style: TextStyle(
            color: textBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: warnings.length,
        itemBuilder: (context, index) {
          final warning = warnings[index];
          return Card(
            elevation: 6,
            shadowColor: Colors.red.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    warning['reason']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18, color: primaryColor),
                      const SizedBox(width: 6),
Text("${'Supervisor:'.tr} ${warning['supervisor']}"),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.event, size: 18, color: secondaryColor),
                      const SizedBox(width: 6),
Text("${'Event:'.tr} ${warning['event']}"),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
