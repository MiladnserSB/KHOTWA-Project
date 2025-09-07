import 'package:get/get.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/projects_model.dart';
import 'package:khotwa/model/top_projects_model.dart';
import 'package:khotwa/service/visitor_service.dart';
import 'package:khotwa/shared/constants/base_url.dart';
import 'package:khotwa/view/intro/Splash_Screen.dart';

class VisitorController extends GetxController {
  final _visitorService = Get.put(VisitorService());

  var allEvents = <EventModel>[].obs;
  var topProjects = <TopProject>[].obs;
  var allProjects = <ProjectModel>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    fetchAllEvents();
    fetchAllProjects();
    fetchTopProjects();
    super.onInit();
  }

  Future<void> fetchAllEvents() async {
    try {
      isLoading(true);
      final events = await _visitorService.getAllEvents();
      allEvents.assignAll(events);
      print(allEvents);
    } catch (e) {
      // Get.snackbar('Error', 'Failed to fetch all events');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAllProjects() async {
    try {
      isLoading(true);
      final projects = await _visitorService.getAllProjects();
      allProjects.assignAll(projects);
    } catch (e) {
      // Get.snackbar('Error', 'Failed to fetch all projects');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchTopProjects() async {
    try {
      final List<TopProject> projects = await _visitorService
          .getTopProjects();
      topProjects.assignAll(projects);
    } catch (e) {
      // Get.snackbar('Error', 'Failed to fetch top projects: $e');
    }
  }


}
