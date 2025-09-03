import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/projects_model.dart';

class AppSearchController extends GetxController {
  final VolunteerController _volunteerController = Get.find<VolunteerController>();

  var query = ''.obs;
  var filteredMyEvents = <EventModel>[].obs;
  var filteredAllEvents = <EventModel>[].obs;
  var filteredAllProjects = <ProjectModel>[].obs;

  void search(String text) {
    query.value = text.toLowerCase();

    if (query.value.isEmpty) {
      filteredMyEvents.clear();
      filteredAllEvents.clear();
      filteredAllProjects.clear();
      return;
    }

   filteredMyEvents.assignAll(
  _volunteerController.myEvents
      .cast<EventModel>()
      .where((event) => event.title.toLowerCase().contains(query.value)),
);


    // البحث في جميع الفعاليات
    filteredAllEvents.assignAll(
      _volunteerController.allEvents.where(
        (event) => event.title.toLowerCase().contains(query.value),
      ),
    );

    // البحث في جميع المشاريع
    filteredAllProjects.assignAll(
      _volunteerController.allProjects.where(
        (project) => project.name.toLowerCase().contains(query.value),
      ),
    );
  }
}
