import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/Search_controller.dart'; // الملف بنفس الاسم
import 'package:khotwa/view/event_and_projects/event_details/event_details_page.dart';
import 'package:khotwa/view/event_and_projects/project_details/project_details_page.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({super.key});

  final AppSearchController searchController = Get.isRegistered<AppSearchController>()
      ? Get.find<AppSearchController>()
      : Get.put(AppSearchController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Search Results".tr)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() {
          final myEvents = searchController.filteredMyEvents;
          final allEvents = searchController.filteredAllEvents;
          final allProjects = searchController.filteredAllProjects;

          if (myEvents.isEmpty && allEvents.isEmpty && allProjects.isEmpty) {
            return Center(child: Text("No results found".tr));
          }

          return ListView(
            children: [
              if (myEvents.isNotEmpty) ...[
                ...myEvents.map((event) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () => Get.to(() => EventDetailsPage(event: event)),
                        child: EventCard(size: size, event: event, elevation: 4),
                      ),
                    )).toList(),
                const SizedBox(height: 20),
              ],
              if (allEvents.isNotEmpty) ...[
              
                ...allEvents.map((event) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () => Get.to(() => EventDetailsPage(event: event)),
                        child: EventCard(size: size, event: event, elevation: 4),
                      ),
                    )).toList(),
                const SizedBox(height: 20),
              ],
              if (allProjects.isNotEmpty) ...[
                ...allProjects.map((project) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () => Get.to(() => ProjectDetailsPage(project: project)),
                        child: ProjectCard(size: size, project: project, elevation: 4),
                      ),
                    )).toList(),
              ],
            ],
          );
        }),
      ),
    );
  }
}

