import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/Search_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/event_details/event_details_page.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';
import 'package:khotwa/view/event_and_projects/project_details/project_details_page.dart';
import 'package:khotwa/view/tasks/task_card.dart';

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({super.key});

  final AppSearchController searchController =
      Get.isRegistered<AppSearchController>()
          ? Get.find<AppSearchController>()
          : Get.put(AppSearchController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:
          theme.brightness == Brightness.dark ? Colors.black : thirdColor,
      appBar: AppBar(
        title: Text(
          "Search Results".tr,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        backgroundColor: theme.brightness == Brightness.dark
            ? primaryColor
            : secondaryColor,
        leading: BackButton(
          color: theme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() {
          final myEvents = searchController.filteredMyEvents;
          final allEvents = searchController.filteredAllEvents;
          final allProjects = searchController.filteredAllProjects;
          final myTasks = searchController.filteredMyTasks;

          if (myEvents.isEmpty &&
              allEvents.isEmpty &&
              allProjects.isEmpty &&
              myTasks.isEmpty) {
            return Center(child: Text("No results found".tr));
          }

          return ListView(
            children: [
              if (myTasks.isNotEmpty) ...[
                ...myTasks.map(
                  (taskRx) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: TaskCard(task: taskRx), 
                  ),
                ),
                const SizedBox(height: 20),
              ],

              if (myEvents.isNotEmpty) ...[
                ...myEvents.map(
                  (event) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: GestureDetector(
                      onTap: () =>
                          Get.to(() => EventDetailsPage(event: event)),
                      child: EventCard(
                        size: size,
                        event: event,
                        elevation: 4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              if (allEvents.isNotEmpty) ...[
                ...allEvents.map(
                  (event) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: GestureDetector(
                      onTap: () =>
                          Get.to(() => EventDetailsPage(event: event)),
                      child: EventCard(
                        size: size,
                        event: event,
                        elevation: 4,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              if (allProjects.isNotEmpty) ...[
                ...allProjects.map(
                  (project) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: GestureDetector(
                      onTap: () => Get.to(
                        () => ProjectDetailsPage(project: project),
                      ),
                      child: ProjectCard(
                        size: size,
                        project: project,
                        elevation: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
