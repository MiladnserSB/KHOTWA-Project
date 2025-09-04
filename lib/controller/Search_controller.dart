import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/projects_model.dart';
import 'package:khotwa/model/tasks_model.dart';

class AppSearchController extends GetxController {
  final VolunteerController _volunteerController =
      Get.find<VolunteerController>();

  var query = ''.obs;
  var filteredMyEvents = <EventModel>[].obs;
  var filteredAllEvents = <EventModel>[].obs;
  var filteredAllProjects = <ProjectModel>[].obs;
  RxList<Rx<TaskModel>> filteredMyTasks = <Rx<TaskModel>>[].obs;

 void searchMyEvents(String text) {
  query.value = text.trim().toLowerCase();

 

  filteredMyEvents.assignAll(
    _volunteerController.myEvents
        .where((event) => event.title.toLowerCase().contains(query.value))
        .toList(),
  );

  filteredAllEvents.clear();
  filteredAllProjects.clear();
  filteredMyTasks.clear();
}


  void searchAllEventsAndAllProjects(String text) {
  query.value = text.trim().toLowerCase();

    filteredAllEvents.assignAll(
      _volunteerController.allEvents
          .where((event) => event.title.toLowerCase().contains(query.value))
          .toList(),
    );


    filteredAllProjects.assignAll(
      _volunteerController.allProjects
          .where((project) => project.name.toLowerCase().contains(query.value))
          .toList(),
    );



    filteredMyEvents.clear();
    filteredMyTasks.clear();
  }

 void searchMyTasks(String text) {
  query.value = text.trim().toLowerCase();

  if (_volunteerController.myTasks.isEmpty) {
    filteredMyTasks.clear();
    return;
  }

  filteredMyTasks.assignAll(
    _volunteerController.myTasks
        .where((taskRx) => taskRx.value.title.toLowerCase().contains(query.value))
        .toList(),
  );

  filteredAllEvents.clear();
  filteredAllProjects.clear();
  filteredMyEvents.clear();
}

}
