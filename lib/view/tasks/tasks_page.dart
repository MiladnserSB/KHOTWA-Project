import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/tasks_model.dart';
import 'package:khotwa/shared/constants/base_url.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/supervisor/create_task/create_task_page.dart';
import 'package:khotwa/view/tasks/animated_task_list_view.dart';
import 'package:khotwa/view/tasks/custom_search_bar.dart';
import 'package:khotwa/view/tasks/task_card.dart';
import 'package:khotwa/widgets/custom_progress_indicator.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final VolunteerController _volunteerController = Get.find<VolunteerController>();
  final TextEditingController _searchController = TextEditingController();
  List<TaskModel> _filteredTasks = [];

  @override
  void initState() {
    super.initState();
    if (_volunteerController.myTasks.isEmpty) {
      _loadTasks();
    } else {
      _filteredTasks = _getTasksFromController();
    }
  }

  Future<void> _loadTasks() async {
    await _volunteerController.fetchMyTasks();
    setState(() {
      _filteredTasks = _getTasksFromController();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TaskModel> _getTasksFromController() {
    return _volunteerController.myTasks.map((taskData) {
      if (taskData is TaskModel) {
        return taskData;
      } else if (taskData is Map<String, dynamic>) {
        return TaskModel.fromJson(taskData);
      } else {
        return TaskModel(
          id: 0,
          title: 'Unknown Task',
          description: '',
          volunteerId: 0,
          assignedBy: 0,
          status: 'unknown',
          dueDate: DateTime.now(),
          volunteerHours: 0,
        );
      }
    }).toList();
  }

  void _filterTasks(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredTasks = _getTasksFromController();
      });
      return;
    }

    final tasks = _getTasksFromController();
    final filtered = tasks.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase()) ||
          task.description.toLowerCase().contains(query.toLowerCase()) ||
          task.status.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredTasks = filtered;
    });
  }

  String _getStatusDisplayText(String status) {
    if (status.toLowerCase() == 'not_started') {
      return 'not started'.tr;
    }
    return status.tr;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          theme.brightness == Brightness.dark ? Colors.black : thirdColor,
      floatingActionButton: roleID == 2
          ? FloatingActionButton(
              onPressed: () {
                Get.to(() => CreateTaskPage());
              },
              backgroundColor: theme.scaffoldBackgroundColor,
              shape: const CircleBorder(),
              child: Icon(Icons.add, color: secondaryColor),
            )
          : const SizedBox(),
      appBar: AppBar(
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        backgroundColor:
            theme.brightness == Brightness.dark ? Colors.black : thirdColor,
        title: Text(
          "My Tasks".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomSearchBar(
              controller: _searchController,
              onChanged: _filterTasks,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (_volunteerController.isLoading.value) {
                  return const Center(child: CustomProgressIndicator());
                }

                final tasks = _filteredTasks;

                if (tasks.isEmpty) {
                  return const Center(child: CustomProgressIndicator());
                }

                return AnimatedTaskListView(
                  size: size,
                  itemHeight: size.height * 0.35,
                  tasks: tasks
                      .map(
                        (task) => TaskCard(
                          task: task,
                          displayedStatus: _getStatusDisplayText(task.status),
                        ),
                      )
                      .toList(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
