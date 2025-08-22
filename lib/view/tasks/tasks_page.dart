import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/supervisor/create_task/create_task_page.dart';
import 'package:khotwa/view/tasks/animated_task_list_view.dart';
import 'package:khotwa/view/tasks/custom_search_bar.dart';
import 'package:khotwa/view/tasks/task_card.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: true
          ? FloatingActionButton(
              onPressed: () {
                Get.to(CreateTaskPage());
              },
              backgroundColor: theme.scaffoldBackgroundColor,
              // ignore: dead_code
              shape: CircleBorder(),
              child: Icon(Icons.add, color: secondaryColor),
            )
          : SizedBox(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: Text(
          "My Tasks".tr,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : secondaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CustomSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: AnimatedTaskListView(
                size: size,
                itemHeight: size.height * 0.35,
                tasks: _dummyTasks,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<TaskCard> _dummyTasks = [
  TaskCard(
    title: "Welcome event setup".tr,
    description: "prepare registration".tr, 
    assignedDate: "2024-07-18", 
    dueDate: "2024-07-20",
    eventName: "new volunteer orientation".tr, 
    supervisorName: "Ahmad Khan", 
    status: "In Progress".tr, 
  ),
  TaskCard(
    title: "community outreach call".tr,
    description: "call community centers".tr,
    assignedDate: "2024-07-20",
    dueDate: "2024-07-22",
    eventName: "food drive campaign".tr,
    supervisorName: "Fatima Al-Mansour",
    status: "Pending".tr,
  ),
];

