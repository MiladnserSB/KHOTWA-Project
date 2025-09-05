// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:khotwa/service/supervisor_service.dart';
// import 'package:khotwa/model/profile_model.dart';

// class ViewAllVolunteersController extends GetxController {
//   final SupervisorService _supervisorService = SupervisorService();

//   final volunteers = <Profile>[].obs;
//   final filteredVolunteers = <Profile>[].obs;
//   final isLoading = true.obs;
//   final searchController = TextEditingController();

//   // Active filters
//   final selectedCities = <String>[].obs;
//   final selectedInterests = <String>[].obs;
//   final selectedDays = <String>[].obs;
//   final selectedTimes = <String>[].obs;
//   final selectedHours = <String>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchVolunteers();
//   }

//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }

//   Future<void> fetchVolunteers() async {
//     try {
//       isLoading.value = true;
//       final response = await _supervisorService.getAllVolunteers();
//       volunteers.assignAll(response.data);
//       filteredVolunteers.assignAll(volunteers);
//     } catch (e) {
//       Get.snackbar("Error", "Failed to load volunteers: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void searchVolunteers(String query) {
//     if (query.isEmpty) {
//       applyFilters(); // reset with filters
//     } else {
//       filteredVolunteers.assignAll(
//         volunteers.where((v) =>
//           v.fullName.toLowerCase().contains(query.toLowerCase()) ||
//           (v.city?.toLowerCase().contains(query.toLowerCase()) ?? false)
//         ),
//       );
//     }
//   }

//   void toggleFilter(List<String> filterList, String value, bool selected) {
//     if (selected) {
//       filterList.add(value);
//     } else {
//       filterList.remove(value);
//     }
//   }

//   void applyFilters() {
//     filteredVolunteers.assignAll(
//       volunteers.where((v) {
//         final cityMatch = selectedCities.isEmpty || selectedCities.contains(v.city);
//         final interestMatch = selectedInterests.isEmpty || 
//           v.interests.any((i) => selectedInterests.contains(i));
//         final dayMatch = selectedDays.isEmpty ||
//           v.availabilityDays.any((d) => selectedDays.contains(d));
//         final timeMatch = selectedTimes.isEmpty ||
//           selectedTimes.contains(v.preferredTime);
//         final hoursMatch = selectedHours.isEmpty || _matchHours(v.totalVolunteerHours);

//         return cityMatch && interestMatch && dayMatch && timeMatch && hoursMatch;
//       }).toList(),
//     );
//   }

//   bool _matchHours(int? totalHours) {
//     if (totalHours == null) return false;
//     if (selectedHours.contains("< 50") && totalHours < 50) return true;
//     if (selectedHours.contains("50-100") && totalHours >= 50 && totalHours <= 100) return true;
//     if (selectedHours.contains("100-150") && totalHours > 100 && totalHours <= 150) return true;
//     if (selectedHours.contains("150+") && totalHours > 150) return true;
//     return false;
//   }
// }
