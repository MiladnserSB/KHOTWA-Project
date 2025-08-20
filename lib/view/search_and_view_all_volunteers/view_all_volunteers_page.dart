import 'package:flutter/material.dart';
import 'package:khotwa/controller/view_all_volunteers_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:get/get.dart';
import 'package:khotwa/view/search_and_view_all_volunteers/filter_dialogue.dart';
import 'package:khotwa/view/search_and_view_all_volunteers/search_result_page.dart';
import 'package:khotwa/view/search_and_view_all_volunteers/volunteer_card.dart';

class ViewAllVolunteersController extends GetxController {
  final volunteers = <VolunteerModel>[].obs;
  final filteredVolunteers = <VolunteerModel>[].obs;
  final isLoading = true.obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchVolunteers();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void fetchVolunteers() async {
    isLoading.value = true;
    
    await Future.delayed(Duration(seconds: 2));
    
    volunteers.assignAll([
      VolunteerModel(
        name: "Sarah Chen",
        hours: "120",
        image: "https://randomuser.me/api/portraits/women/44.jpg",
        city: "Damascus",
        preferredTime: "Morning",
        availability: "Weekends"
      ),
      VolunteerModel(
        name: "Michael Davis",
        hours: "85",
        image: "https://randomuser.me/api/portraits/men/32.jpg",
        city: "Aleppo",
        preferredTime: "Evening",
        availability: "Weekdays"
      ),
      VolunteerModel(
        name: "Maria Rodriguez",
        hours: "100",
        image: "https://randomuser.me/api/portraits/women/65.jpg",
        city: "Homs",
        preferredTime: "Afternoon",
        availability: "Flexible"
      ),
      VolunteerModel(
        name: "David Lee",
        hours: "90",
        image: "https://randomuser.me/api/portraits/men/71.jpg",
        city: "Latakia",
        preferredTime: "Morning",
        availability: "Weekends"
      ),
    ]);
    
    filteredVolunteers.assignAll(volunteers);
    isLoading.value = false;
  }

  void searchVolunteers(String query) {
    if (query.isEmpty) {
      filteredVolunteers.assignAll(volunteers);
    } else {
      filteredVolunteers.assignAll(volunteers.where((volunteer) =>
          volunteer.name.toLowerCase().contains(query.toLowerCase()) ||
          volunteer.city.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void applyFilters(Map<String, dynamic> filters) {
    // Filter logic will be implemented here
    filteredVolunteers.assignAll(volunteers);
  }
}

class ViewAllVolunteersPage extends StatelessWidget {
  ViewAllVolunteersPage({super.key});

  final ViewAllVolunteersController controller = Get.put(ViewAllVolunteersController());

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
                    onChanged: (value) {
                      controller.searchVolunteers(value);
                    },
                    onSubmitted: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SearchResultsPage(searchQuery: value),
                        ),
                      );
                    },
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
            
            // Volunteer List
            Obx(() => controller.isLoading.value 
              ? Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                )
              : Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      if (constraints.maxWidth > 900) {
                        crossAxisCount = 3;
                      } else if (constraints.maxWidth > 600) {
                        crossAxisCount = 2;
                      }
                      return GridView.builder(
                        itemCount: controller.filteredVolunteers.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 3.2,
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
                ),
            ),
          ],
        ),
      ),
    );
  }
}

