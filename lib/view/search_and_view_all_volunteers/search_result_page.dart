import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/supervisor_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/search_and_view_all_volunteers/filter_dialogue.dart';
import 'package:khotwa/view/search_and_view_all_volunteers/volunteer_card.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchQuery;
  final SupervisorController controller = Get.find<SupervisorController>();

  SearchResultsPage({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    // Initialize search
    controller.searchController.text = searchQuery;
    controller.searchVolunteers(searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results", style: TextStyle(color: textBlack)),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔎 Search Bar + Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: "Search Volunteers...",
                      hintStyle: const TextStyle(color: grey),
                      prefixIcon: const Icon(Icons.search, color: grey),
                      filled: true,
                      fillColor: grey.withOpacity(0.1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: grey.withOpacity(0.3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    onChanged: controller.searchVolunteers,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: primaryColor.withOpacity(0.3)),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: primaryColor),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => FilterDialog(),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 🎯 Active Filters
            Obx(() {
              final hasFilters = controller.selectedCities.isNotEmpty ||
                  controller.selectedInterests.isNotEmpty ||
                  controller.selectedDays.isNotEmpty ||
                  controller.selectedTimes.isNotEmpty ||
                  controller.selectedHours.isNotEmpty;

              if (!hasFilters) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    ...controller.selectedCities.map((city) => _buildFilterChip(city, controller.selectedCities)),
                    ...controller.selectedInterests.map((i) => _buildFilterChip(i, controller.selectedInterests)),
                    ...controller.selectedDays.map((d) => _buildFilterChip(d, controller.selectedDays)),
                    ...controller.selectedTimes.map((t) => _buildFilterChip(t, controller.selectedTimes)),
                    ...controller.selectedHours.map((h) => _buildFilterChip(h, controller.selectedHours)),
                    ActionChip(
                      label: const Text("Clear All"),
                      onPressed: () {
                        controller.selectedCities.clear();
                        controller.selectedInterests.clear();
                        controller.selectedDays.clear();
                        controller.selectedTimes.clear();
                        controller.selectedHours.clear();
                        controller.applyFilters();
                      },
                    )
                  ],
                ),
              );
            }),

            // 📋 Results
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: primaryColor));
                }
                if (controller.filteredVolunteers.isEmpty) {
                  return const Center(
                    child: Text("No volunteers found", style: TextStyle(color: grey)),
                  );
                }
                return ListView.builder(
                  itemCount: controller.filteredVolunteers.length,
                  itemBuilder: (context, index) {
                    final volunteer = controller.filteredVolunteers[index];
                    return VolunteerCard(volunteer: volunteer);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// 🏷 Helper for removable filter chips
  Widget _buildFilterChip(String label, List<String> list) {
    final SupervisorController controller = Get.find<SupervisorController>();
    return Chip(
      label: Text(label),
      onDeleted: () {
        controller.toggleFilter(list, label, false);
        controller.applyFilters();
      },
      deleteIcon: const Icon(Icons.close, size: 16),
    );
  }
}
