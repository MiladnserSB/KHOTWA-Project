import 'package:get/get.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/profile_model.dart';
import 'package:khotwa/model/projects_model.dart';
import 'package:khotwa/model/tasks_model.dart';
import 'package:khotwa/model/top_projects_model.dart';
import 'package:khotwa/service/volunteer_service.dart';
import 'package:khotwa/shared/constants/base_url.dart';

class VolunteerController extends GetxController {
 final VolunteerService _volunteerService = Get.put(VolunteerService());
  var myEvents = <EventModel>[].obs;
  var myTasks = <Rx<TaskModel>>[].obs;
  var myEvaluations = [].obs;
  var myBadgets = [].obs;
  var isLoading = false.obs;
  var allEvents = <EventModel>[].obs;
  var topProjects = <TopProject>[].obs;
  var allProjects = <ProjectModel>[].obs;
  var recommendedEvents = <EventModel>[].obs;
   var registeredEvents = <int, bool>{}.obs;
  var profile = Rxn<ProfileModel>(); 
  var isProfileLoading = false.obs;

  @override
  void onInit() {
    fetchProfile();
    fetchMyBadgets();
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

  Future<void> fetchMyBadgets() async {
     try {
    isLoading(true);
    final badgets = await _volunteerService.getMyBadges();
    print(badgets);
    myBadgets.assignAll(badgets);
     }catch (e) {
    Get.snackbar('Error', 'Failed to fetch My badgets');
  } finally {
    isLoading(false);
  }
  }

Future<void> registerForEvent(int eventId) async {
    try {
      isLoading.value = true;
      // TODO: call your API here
      await Future.delayed(const Duration(seconds: 1));
      registeredEvents[eventId] = true;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> withdrawFromEvent(int eventId) async {
    try {
      isLoading.value = true;
      // TODO: call your API here
      await Future.delayed(const Duration(seconds: 1));
      registeredEvents[eventId] = false;
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
    print("we fetch the prjects");
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
    print("We are done for here");
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
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch profile');
    } finally {
      isProfileLoading(false);
    }
  }


    Future<void> uploadProfileImage(String filePath) async {
    try {
      isProfileLoading(true);
      print(filePath);
      final result = await _volunteerService.uploadProfileImage( filePath);
print("done for upload here");
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

}