import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/supervisor_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';

class FilterDialog extends StatelessWidget {
  FilterDialog({super.key});
  final SupervisorController controller = Get.find<SupervisorController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filter Volunteers", style: TextStyle(color: textBlack)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("City", ["Damascus", "Aleppo", "Homs", "Latakia", "Hama", "Tartus"], controller.selectedCities),
            _buildSection("Interests", [
              "Education & Teaching",
              "Social Media & Marketing",
              "Event Organization",
              "Healthcare Support",
              "Administrative Support",
              "Community Outreach"
            ], controller.selectedInterests),
            _buildSection("Availability", [
              "Everyday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
            ], controller.selectedDays),
            _buildSection("Preferred Time", [
              "Morning", "Afternoon", "Evening"
            ], controller.selectedTimes),
            _buildSection("Total Hours", [
              "< 50", "50-100", "100-150", "150+"
            ], controller.selectedHours),
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
            controller.applyFilters();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          child: const Text("Apply", style: TextStyle(color: white)),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<String> options, List<String> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((e) {
            final isSelected = selectedList.contains(e);
            return FilterChip(
              label: Text(e),
              selected: isSelected,
              onSelected: (selected) {
                controller.toggleFilter(selectedList, e, selected);
              },
              backgroundColor: grey.withOpacity(0.1),
              selectedColor: primaryColor.withOpacity(0.2),
              labelStyle: const TextStyle(color: textBlack),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
