import 'package:get/get.dart';
import 'package:khotwa/service/supervisor_service.dart';
import 'package:khotwa/shared/constants/app_routes.dart';

class SupervisorController extends GetxController {
  final SupervisorService _supervisorService = SupervisorService();
  
  var eventAttendance = [].obs;
  var eventRegistrations = [].obs;
  var eventEvaluations = [].obs;
  var isLoading = false.obs;

  Future<void> generateEventQR(int eventId) async {
    try {
      isLoading(true);
      final qrData = await _supervisorService.generateEventQR(eventId);
      // Handle QR data (show dialog, navigate to QR page, etc.)
      Get.toNamed(AppRoutes.showQR, arguments: qrData);
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate QR code');
    } finally {
      isLoading(false);
    }
  }

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

  Future<void> manualCheckIn(int eventId, List<int> volunteerIds) async {
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

  Future<void> manualCheckOut(int eventId, List<int> volunteerIds) async {
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

  Future<void> createTask(Map<String, dynamic> taskData) async {
    try {
      isLoading(true);
      await _supervisorService.createTask(taskData);
      Get.snackbar('Success', 'Task created successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create task');
    } finally {
      isLoading(false);
    }
  }
}