import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/tasks/animated_task_list_view.dart';
import 'package:khotwa/view/tasks/custom_search_bar.dart';
import 'package:khotwa/view/tasks/task_card.dart';


class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: const Text("My Tasks", style: TextStyle(color: textBlack)),
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

final List<TaskCard> _dummyTasks = const [
  TaskCard(
    title: "Welcome Event Setup",
    description: "Prepare registration desks and welcome packets for new volunteers.",
    assignedDate: "2024-07-18",
    dueDate: "2024-07-20",
    eventName: "New Volunteer Orientation",
    supervisorName: "Ahmad Khan",
    status: "In Progress",
  ),
  TaskCard(
    title: "Community Outreach Call",
    description: "Call community centers to confirm participation in the upcoming food drive.",
    assignedDate: "2024-07-20",
    dueDate: "2024-07-22",
    eventName: "Food Drive Campaign",
    supervisorName: "Fatima Al-Mansour",
    status: "Pending",
  ),
];
