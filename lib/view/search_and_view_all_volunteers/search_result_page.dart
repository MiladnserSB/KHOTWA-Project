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
    controller.searchController.text = searchQuery;
    controller.searchVolunteers(searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results", style: TextStyle(color: textBlack)),
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar + Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: "Search Volunteers...",
                      hintStyle: TextStyle(color: grey),
                      prefixIcon: Icon(Icons.search, color: grey),
                      filled: true,
                      fillColor: grey.withOpacity(0.1),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: grey.withOpacity(0.3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    onSubmitted: controller.searchVolunteers,
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
                    icon: Icon(Icons.filter_list, color: primaryColor),
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
            const SizedBox(height: 20),

            // Results
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
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
}
