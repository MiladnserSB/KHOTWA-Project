import 'package:get/get.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/top_projects_model.dart';
import 'package:khotwa/service/volunteer_service.dart';

class VolunteerController extends GetxController {
 final VolunteerService _volunteerService = Get.put(VolunteerService());
  var myEvents = [].obs;
  var myTasks = [].obs;
  var myEvaluations = [].obs;
  var myBadges = [].obs;
  var isLoading = false.obs;
  var allEvents = <EventModel>[].obs;
  var topProjects = <TopProject>[].obs;
  var recommendedEvents = <EventModel>[].obs;
  @override
  void onInit() {
 Future.delayed(Duration(milliseconds: 100), () {
      fetchTopProjects();
    });
    super.onInit();
  }

  Future<void> fetchVolunteerData() async {
    try {
      isLoading(true);
      await Future.wait([
        fetchMyEvents(),
        fetchMyTasks(),
        fetchMyEvaluations(),
        fetchMyBadges(),
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch volunteer data');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchMyEvents() async {
    final events = await _volunteerService.getMyEvents();
    myEvents.assignAll(events);
  }

  Future<void> fetchMyTasks() async {
    final tasks = await _volunteerService.getMyTasks();
    myTasks.assignAll(tasks);
  }

  Future<void> fetchMyEvaluations() async {
    final evaluations = await _volunteerService.getMyEvaluations();
    myEvaluations.assignAll(evaluations);
  }

  Future<void> fetchMyBadges() async {
    final badges = await _volunteerService.getMyBadges();
    myBadges.assignAll(badges);
  }

  Future<void> registerForEvent(int eventId) async {
    try {
      isLoading(true);
      await _volunteerService.registerForEvent(eventId);
      await fetchMyEvents();
      Get.snackbar('Success', 'Registered for event successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to register for event');
    } finally {
      isLoading(false);
    }
  }

  Future<void> withdrawFromEvent(int eventId) async {
    try {
      isLoading(true);
      await _volunteerService.withdrawFromEvent(eventId);
      await fetchMyEvents();
      Get.snackbar('Success', 'Withdrawn from event successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to withdraw from event');
    } finally {
      isLoading(false);
    }
  }

  Future<void> submitFeedback(int eventId, int rating, String comment) async {
    try {
      isLoading(true);
      await _volunteerService.submitFeedback(eventId, rating, comment);
      Get.snackbar('Success', 'Feedback submitted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit feedback');
    } finally {
      isLoading(false);
    }
  }

  Future<void> markTaskCompleted(int taskId) async {
    try {
      isLoading(true);
      await _volunteerService.markTaskCompleted(taskId);
      await fetchMyTasks();
      Get.snackbar('Success', 'Task marked as completed');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update task');
    } finally {
      isLoading(false);
    }
  }

 

Future<void> fetchAllEvents() async {
  try {
    isLoading(true);
    final events = await _volunteerService.getAllEvents();
    allEvents.assignAll(events);
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch all events');
  } finally {
    isLoading(false);
  }
}

Future<void> fetchTopProjects() async {
  try {
    final List<TopProject> projects = await _volunteerService.getTopProjects();
    print("We are done for here");
    topProjects.assignAll(projects);
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch top projects: $e');

  }
}
Future<void> fetchRecommendedEvents(int eventId) async {
  try {
    final dynamic events = await _volunteerService.getRecommendedEvents(eventId);
    if (events is List) {
      final List<EventModel> eventModels = events.map((item) {
        if (item is EventModel) {
          return item;
        } else if (item is Map<String, dynamic>) {
          return EventModel.fromJson(item);
        } else {
          throw Exception('Invalid event data format');
        }
      }).toList();
      
      recommendedEvents.assignAll(eventModels);
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch recommended events');
  }
}

}