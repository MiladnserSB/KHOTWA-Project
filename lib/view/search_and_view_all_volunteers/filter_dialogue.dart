
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/view_all_volunteers_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';

class FilterDialog extends StatelessWidget {
  FilterDialog({super.key});

  final ViewAllVolunteersController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filter Volunteers", style: TextStyle(color: textBlack)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("City", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                "Damascus", "Aleppo", "Homs", "Latakia", "Hama", "Tartus"
              ].map((e) => FilterChip(
                label: Text(e), 
                onSelected: (_) {},
                backgroundColor: grey.withOpacity(0.1),
                selectedColor: primaryColor.withOpacity(0.2),
                labelStyle: TextStyle(color: textBlack),
              )).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Interests", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                "Education & Teaching",
                "Social Media & Marketing",
                "Event Organization",
                "Healthcare Support",
                "Administrative Support",
                "Community Outreach"
              ].map((e) => FilterChip(
                label: Text(e), 
                onSelected: (_) {},
                backgroundColor: grey.withOpacity(0.1),
                selectedColor: primaryColor.withOpacity(0.2),
                labelStyle: TextStyle(color: textBlack),
              )).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Availability", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                "Everyday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
              ].map((e) => FilterChip(
                label: Text(e), 
                onSelected: (_) {},
                backgroundColor: grey.withOpacity(0.1),
                selectedColor: primaryColor.withOpacity(0.2),
                labelStyle: TextStyle(color: textBlack),
              )).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Preferred Time", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                "1-2 hours/week",
                "3-5 hours/week",
                "6-10 hours/week",
                "More than 10 hours/week"
              ].map((e) => FilterChip(
                label: Text(e),
                onSelected: (_) {},
                backgroundColor: grey.withOpacity(0.1),
                selectedColor: primaryColor.withOpacity(0.2),
                labelStyle: TextStyle(color: textBlack),
              )).toList(),
            ),
            const SizedBox(height: 16),
            const Text("Total Hours", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                "< 50", "50-100", "100-150", "150+"
              ].map((e) => FilterChip(
                label: Text(e),
                onSelected: (_) {},
                backgroundColor: grey.withOpacity(0.1),
                selectedColor: primaryColor.withOpacity(0.2),
                labelStyle: TextStyle(color: textBlack),
              )).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: grey)),
        ),
        ElevatedButton(
          onPressed: () {
            // Apply filters logic
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          child: const Text("Apply", style: TextStyle(color: white)),
        ),
      ],
    );
  }
}