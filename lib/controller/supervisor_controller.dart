import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:khotwa/model/profile_model.dart';
import 'package:khotwa/service/supervisor_service.dart';
import 'package:khotwa/view/supervisor/attendence/show_qr_in_page.dart';
import 'package:khotwa/view/supervisor/attendence/show_qr_out_page.dart';

class SupervisorController extends GetxController {
  final SupervisorService _supervisorService = SupervisorService();

  // Event data
  var eventAttendance = [].obs;
  var eventRegistrations = [].obs;
  var eventEvaluations = [].obs;

  // Volunteers
  var volunteers = <Profile>[].obs;
  var filteredVolunteers = <Profile>[].obs;

  // State
  var isLoading = false.obs;
  final searchController = TextEditingController();

  // Active filters
  final selectedCities = <String>[].obs;
  final selectedInterests = <String>[].obs;
  final selectedDays = <String>[].obs;
  final selectedTimes = <String>[].obs;
  final selectedHours = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllVolunteers();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // ----------------------------
  // Volunteers
  // ----------------------------
  Future<void> fetchAllVolunteers() async {
    try {
      isLoading(true);
      final response = await _supervisorService.getAllVolunteers();
      volunteers.assignAll(response.data);
      filteredVolunteers.assignAll(volunteers);
      print("Done fecthing colunteer");
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch volunteers: $e');
    } finally {
      isLoading(false);
    }
  }

void searchVolunteers(String query) {
  searchQuery.value = query;
  applyFilters();
}

  void toggleFilter(List<String> filterList, String value, bool selected) {
    if (selected) {
      filterList.add(value);
    } else {
      filterList.remove(value);
    }
  }

var searchQuery = ''.obs;




void applyFilters() {
  final query = searchController.text.trim().toLowerCase();

  filteredVolunteers.assignAll(
    volunteers.where((v) {
      // Search condition
      final matchesSearch = query.isEmpty ||
          (v.fullName?.toLowerCase().contains(query) ?? false) ||
          (v.city?.toLowerCase().contains(query) ?? false);

      // Filters
      final cityMatch =
          selectedCities.isEmpty || selectedCities.contains(v.city);

      final interestMatch = selectedInterests.isEmpty ||
          (v.interests ?? []).any((i) => selectedInterests.contains(i));

      final dayMatch = selectedDays.isEmpty ||
          (v.availabilityDays ?? []).any((d) => selectedDays.contains(d));

      final timeMatch = selectedTimes.isEmpty ||
          selectedTimes.contains(v.preferredTime);

      final hoursMatch =
          selectedHours.isEmpty || _matchHours(v.totalVolunteerHours);

      return matchesSearch &&
          cityMatch &&
          interestMatch &&
          dayMatch &&
          timeMatch &&
          hoursMatch;
    }).toList(),
  );
}



  bool _matchHours(int? totalHours) {
    if (totalHours == null) return false;
    if (selectedHours.contains("< 50") && totalHours < 50) return true;
    if (selectedHours.contains("50-100") && totalHours >= 50 && totalHours <= 100) return true;
    if (selectedHours.contains("100-150") && totalHours > 100 && totalHours <= 150) return true;
    if (selectedHours.contains("150+") && totalHours > 150) return true;
    return false;
  }

  // ----------------------------
  // QR Codes
  // ----------------------------
  Future<void> generateEventQR(int eventId, bool isCheckIn) async {
    try {
      isLoading(true);

      final qrBytes = await _supervisorService.generateEventQR(eventId);

      if (isCheckIn) {
        Get.to(() => const ShowQrInPage(), arguments: qrBytes);
      } else {
        Get.to(() => const ShowQrOutPage(), arguments: qrBytes);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate QR code: $e');
    } finally {
      isLoading(false);
    }
  }

  // ----------------------------
  // Attendance
  // ----------------------------
  Future<void> fetchEventAttendance(int eventId) async {
    try {
      isLoading(true);
      final attendance = await _supervisorService.getEventAttendance(eventId);
      eventAttendance.assignAll(attendance);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch attendance');
    } finally {
      isLoading(false);
    }
  }

  Future<void> manualCheckIn(int eventId, List<dynamic> volunteerIds) async {
    try {
      isLoading(true);
      await _supervisorService.manualCheckIn(eventId, volunteerIds);
      await fetchEventAttendance(eventId);
      Get.snackbar('Success', 'Manual check-in completed');
    } catch (e) {
      Get.snackbar('Error', 'Failed to perform manual check-in');
    } finally {
      isLoading(false);
    }
  }

  Future<void> manualCheckOut(int eventId, List<dynamic> volunteerIds) async {
    try {
      isLoading(true);
      await _supervisorService.manualCheckOut(eventId, volunteerIds);
      await fetchEventAttendance(eventId);
      Get.snackbar('Success', 'Manual check-out completed');
    } catch (e) {
      Get.snackbar('Error', 'Failed to perform manual check-out');
    } finally {
      isLoading(false);
    }
  }

  // ----------------------------
  // Event Registrations & Evaluations
  // ----------------------------
  Future<void> fetchEventRegistrations(int eventId) async {
    try {
      isLoading(true);
      final registrations = await _supervisorService.getEventRegistrations(eventId);
      eventRegistrations.assignAll(registrations);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch registrations');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchEventEvaluations(int eventId) async {
    try {
      isLoading(true);
      final evaluations = await _supervisorService.getEventEvaluations(eventId);
      eventEvaluations.assignAll(evaluations);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch evaluations');
    } finally {
      isLoading(false);
    }
  }

  Future<void> createEvaluation(Map<String, dynamic> evaluationData) async {
    try {
      isLoading(true);
      await _supervisorService.createEvaluation(evaluationData);
      Get.snackbar('Success', 'Evaluation created successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create evaluation');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateEvaluation(int evaluationId, Map<String, dynamic> updateData) async {
    try {
      isLoading(true);
      await _supervisorService.updateEvaluation(evaluationId, updateData);
      Get.snackbar('Success', 'Evaluation updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update evaluation');
    } finally {
      isLoading(false);
    }
  }

  // ----------------------------
  // Tasks
  // ----------------------------
  Future<void> createTask({
    required String title,
    required String description,
    required int volunteerId,
    required int volunteerHours,
    required String startDate,
    required String dueDate,
  }) async {
    try {
      isLoading(true);

      await _supervisorService.createTask(
        title: title,
        description: description,
        volunteerId: volunteerId,
        volunteerHours: volunteerHours,
        startDate: startDate,
        dueDate: dueDate,
      );

      Get.snackbar('Success', 'Task created successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create task: $e');
    } finally {
      isLoading(false);
    }
  }
}
