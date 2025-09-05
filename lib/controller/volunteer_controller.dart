import 'package:get/get.dart';
import 'package:khotwa/model/badgets_model.dart';
import 'package:khotwa/model/event_evaluations_model.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/profile_model.dart';
import 'package:khotwa/model/projects_model.dart';
import 'package:khotwa/model/tasks_model.dart';
import 'package:khotwa/model/top_projects_model.dart';
import 'package:khotwa/model/volunteer_log_model.dart';
import 'package:khotwa/service/volunteer_service.dart';
import 'package:khotwa/shared/constants/base_url.dart';

class VolunteerController extends GetxController {
 final VolunteerService _volunteerService = Get.put(VolunteerService());
  var myEvents = <EventModel>[].obs;
  var myTasks = <Rx<TaskModel>>[].obs;
  var myEvaluations = [].obs;
  var allEvents = <EventModel>[].obs;
  var topProjects = <TopProject>[].obs;
  var allProjects = <ProjectModel>[].obs;
  var recommendedEvents = <EventModel>[].obs;
   var registeredEvents = <int, bool>{}.obs;
  var profile = Rxn<ProfileModel>(); 
  var isProfileLoading = false.obs;
  var checkInStatus = <int, bool>{}.obs;
  var checkOutStatus = <int, bool>{}.obs;  
  var eventFeedback = Rxn<EventEvaluationModel>();
var isFeedbackLoading = false.obs;


 var volunteerLog = <VolunteerLog>[].obs;
  var isVolunteerLogLoading = false.obs;
  var warnings = <Evaluation>[].obs; 

  var myBadgets = <BadgetModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchProfile();
    fetchVolunteerLog();
    fetchBadges();
    super.onInit();
  }

  Future<void> fetchMyEvents() async {
    try {
    isLoading(true);
    final events = await _volunteerService.getMyEvents();
    myEvents.assignAll(events);
    }catch (e) {
    Get.snackbar('Error', 'Failed to fetch My events');
  } finally {
    isLoading(false);
  }
  }

  Future<void> fetchMyTasks() async {
    final tasks = await _volunteerService.getMyTasks();
    myTasks.assignAll(tasks.map((t) => t.obs));

  }

  Future<void> fetchMyEvaluations() async {
    final evaluations = await _volunteerService.getMyEvaluations();
    myEvaluations.assignAll(evaluations);
  }

   Future<void> fetchBadges() async {
    try {
      isLoading(true);
      final badges = await _volunteerService.getMyBadges();
      myBadgets.assignAll(badges.cast<BadgetModel>());
    } catch (e) {
      Get.snackbar('Error', 'Failed to load badges: $e');
    } finally {
      isLoading(false);
    }
  }

Future<void> registerForEvent(int eventId) async {
  try {
    isLoading.value = true;
    final result = await _volunteerService.registerForEvent(eventId);

    if (result['status'] == true) {
      registeredEvents[eventId] = true;
      Get.snackbar('Success', result['message'] ?? 'Registered successfully');
      await fetchMyEvents(); 
    } else {
      Get.snackbar('Error', result['message'] ?? 'Failed to register');
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to register for event: $e');
  } finally {
    isLoading.value = false;
  }
}

Future<void> withdrawFromEvent(int eventId) async {
  try {
    isLoading.value = true;
    final result = await _volunteerService.withdrawFromEvent(eventId);

    if (result['status'] == true) {
      registeredEvents[eventId] = false;
      Get.snackbar('Success', result['message'] ?? 'Withdrawn successfully');
      await fetchMyEvents(); 
    } else {
      Get.snackbar('Error', result['message'] ?? 'Failed to withdraw');
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to withdraw from event: $e');
  } finally {
    isLoading.value = false;
  }
}


bool isRegisteredFor(int eventId) {
  return myEvents.any((event) => event.id == eventId);
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


Future<void> updateTaskStatus(int taskId, String action) async {
  try {
    isLoading(true);
    await _volunteerService.updateTaskStatus(taskId, action);

    final index = myTasks.indexWhere((t) => t.value.id == taskId);
    if (index != -1) {
      final taskRx = myTasks[index];
      String newStatus = taskRx.value.status;

      switch (action) {
        case 'accept': newStatus = 'in_progress'; break;
        case 'reject': newStatus = 'rejected'; break;
        case 'complete': newStatus = 'completed'; break;
        case 'withdraw': newStatus = 'withdrawn'; break;
      }

      taskRx.value = taskRx.value.copyWith(status: newStatus);
    }

    Get.snackbar('Success'.tr, 'Task status updated successfully'.tr);
  } catch (e) {
    Get.snackbar('Error'.tr, 'Failed to update task status'.tr);
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
Future<void> fetchAllProjects() async {
  try {
    isLoading(true);
    final projects = await _volunteerService.getAllProjects();
    allProjects.assignAll(projects);
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch all projects');
  } finally {
    isLoading(false);
  }
}
Future<void> fetchTopProjects() async {
  try {
    final List<TopProject> projects = await _volunteerService.getTopProjects();
    topProjects.assignAll(projects);
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch top projects: $e');

  }
}
Future<void> fetchRecommendedEvents() async {
  try {
    final dynamic events = await _volunteerService.getRecommendedEvents();
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


Future<void> fetchProfile() async {
    try {
      isProfileLoading(true);
      final fetchedProfile = await _volunteerService.getProfile();
      profile.value = fetchedProfile;
      await   fetchVolunteerLog();

    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch profile');
    } finally {
      isProfileLoading(false);
    }
  }


    Future<void> uploadProfileImage(String filePath) async {
    try {
      isProfileLoading(true);
      final result = await _volunteerService.uploadProfileImage( filePath);
      await fetchProfile();

      Get.snackbar('Success', result['message'] ?? 'Profile image updated');
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', 'Failed to upload profile image ${e.toString()} ',);
    } finally {
      isProfileLoading(false);
    }
  }
Future<void> updateProfile(Map<String, dynamic> profileData) async {
  try {
    isProfileLoading(true);
    final updatedProfile = await _volunteerService.updateProfile(profileData);
    profile.value = updatedProfile; // update observable profile
    Get.snackbar('Success', updatedProfile.message);
  } catch (e) {
    Get.snackbar('Error', 'Failed to update profile: $e');
  } finally {
    isProfileLoading(false);
  }
}
Future<void> handleCheckIn(int eventId, String qrToken) async {
  try {
    isLoading(true);
    final result = await _volunteerService.checkIn(qrToken);
    if (result['status'] == true) {
      checkInStatus[eventId] = true;
      Get.snackbar('Success', result['message'] ?? 'Checked in successfully');
    } else {
      Get.snackbar('Error', result['message'] ?? 'Failed to check in');
    }
  } catch (e) {
    Get.snackbar('Error', 'Check-in failed: $e');
  } finally {
    isLoading(false);
  }
}

Future<void> handleCheckOut(int eventId, String qrToken) async {
  try {
    isLoading(true);
    final result = await _volunteerService.checkOut(qrToken);
    if (result['status'] == true) {
      checkOutStatus[eventId] = true;
      Get.snackbar('Success', result['message'] ?? 'Checked out successfully');
    } else {
      Get.snackbar('Error', result['message'] ?? 'Failed to check out');
    }
  } catch (e) {
    Get.snackbar('Error', 'Check-out failed: $e');
  } finally {
    isLoading(false);
  }
}


Future<void> fetchEventFeedback(int eventId) async {
  try {
    isFeedbackLoading(true);

    final result = await _volunteerService.getEventFeedback(eventId);
    eventFeedback.value = result.data;

    Get.snackbar('Success', result.message);
  } catch (e) {
    Get.snackbar('Error', 'Failed to load feedback: $e');
  } finally {
    isFeedbackLoading(false);
  }
}
Future<void> submitEventFeedback(int eventId, int rating, String comment) async {
  try {
    isLoading(true);
    final result = await _volunteerService.submitEventFeedback(eventId, rating, comment);

    eventFeedback.value = result.data;

    Get.snackbar('Success', result.message);
  } catch (e) {
    Get.snackbar('Error', 'Failed to submit feedback: $e');
  } finally {
    isLoading(false);
  }
}




Future<void> fetchVolunteerLog({int? eventId}) async {
  try {
    isVolunteerLogLoading(true);

    final log = await _volunteerService.getVolunteerLog(eventId: eventId);

    if (log is List) {
      final parsed = log
          .map((e) => VolunteerLog.fromJson(e as Map<String, dynamic>))
          .toList();
      volunteerLog.assignAll(parsed);

      final extractedWarnings = parsed
          .expand((vLog) => vLog.evaluations ?? [])
          .where((eval) => eval.warning != null)
          .cast<Evaluation>()   
          .toList();

      warnings.assignAll(extractedWarnings);
    } else {
      throw Exception('Invalid data format for volunteer log');
    }
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch volunteer log: $e');
  } finally {
    isVolunteerLogLoading(false);
  }
}









}