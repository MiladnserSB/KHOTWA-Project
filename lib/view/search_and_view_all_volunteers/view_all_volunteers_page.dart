import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/supervisor_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/search_and_view_all_volunteers/filter_dialogue.dart';
import 'package:khotwa/view/search_and_view_all_volunteers/volunteer_card.dart';

class ViewAllVolunteersPage extends StatelessWidget {
  ViewAllVolunteersPage({super.key});

  final SupervisorController controller = Get.put(SupervisorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volunteer List", style: TextStyle(color: textBlack)),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar with Filter Button
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (value) => controller.searchVolunteers(value),
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

            // Active filters section
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

            const SizedBox(height: 10),

            // Volunteer List
            Obx(() {
              if (controller.isLoading.value) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                );
              }

              if (controller.filteredVolunteers.isEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text("No volunteers found", style: TextStyle(color: grey)),
                  ),
                );
              }

              return Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 1;
                    double childAspectRatio = 3.2;

                    if (constraints.maxWidth > 900) {
                      crossAxisCount = 3;
                      childAspectRatio = 1.8;
                    } else if (constraints.maxWidth > 600) {
                      crossAxisCount = 2;
                      childAspectRatio = 2.0;
                    } else {
                      crossAxisCount = 1;
                      childAspectRatio = 2.5;
                    }

                    return GridView.builder(
                      itemCount: controller.filteredVolunteers.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: childAspectRatio,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        return VolunteerCard(
                          volunteer: controller.filteredVolunteers[index],
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

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
