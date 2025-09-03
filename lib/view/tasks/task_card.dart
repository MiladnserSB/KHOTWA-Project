import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/tasks_model.dart';
import 'package:khotwa/shared/constants/colors.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final String displayedStatus;

  const TaskCard({
    super.key,
    required this.task,
    required this.displayedStatus,
  });

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
    VoidCallback onConfirm,
  ) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.grey
                : Colors.grey,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              foregroundColor: white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel".tr),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              foregroundColor: white,
            ),
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text("Confirm".tr),
          ),
        ],
      ),
    );
  }

  // Method to handle task status update
  void _handleTaskAction(String action, BuildContext context) {
    final controller = Get.find<VolunteerController>();
    
    _showConfirmationDialog(
      context,
      "Update Status".tr,
      "Are you sure you want to ${action.tr} this task?".tr,
      () {
        controller.updateTaskStatus(task.id, action).then((_) {
          // Show success message
          Get.snackbar(
            "Success".tr,
            "Task status updated successfully".tr,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }).catchError((error) {
          // Show error message
          Get.snackbar(
            "Error".tr,
            "Failed to update task status: $error".tr,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<VolunteerController>();

    Color statusColor;
    switch (task.status.toLowerCase()) {
      case 'in_progress':
        statusColor = Colors.green;
        break;
      case 'not_started':
        statusColor = Colors.orange;
        break;
      case 'completed':
        statusColor = Colors.blue;
        break;
      default:
        statusColor = grey;
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double baseFont = constraints.maxWidth * 0.045;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: baseFont + 2,
                    fontWeight: FontWeight.bold,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white
                        : textBlack,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  task.description,
                  style: TextStyle(
                    fontSize: baseFont,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white70
                        : grey,
                  ),
                ),
                const SizedBox(height: 12),
                _infoRow(
                  Icons.calendar_today,
                  "${'Assigned'.tr}: ${task.startDate != null ? task.startDate.toString().split(' ')[0] : 'N/A'}",
                  baseFont,
                  theme,
                ),
                _infoRow(
                  Icons.event, 
                  "${'Due'.tr}: ${task.dueDate.toString().split(' ')[0]}", 
                  baseFont, 
                  theme
                ),
                _infoRow(
                  Icons.person,
                  "${'Supervisor ID'.tr}: ${task.assignedBy}",
                  baseFont,
                  theme,
                ),
                _infoRow(
                  Icons.timer,
                  "${'Volunteer Hours'.tr}: ${task.volunteerHours}",
                  baseFont,
                  theme,
                ),

                const SizedBox(height: 10),
                Chip(
                  label: Text(
                    displayedStatus,
                    style: TextStyle(fontSize: baseFont, color: statusColor),
                  ),
                  backgroundColor: statusColor.withOpacity(0.1),
                ),
                const SizedBox(height: 12),
                
                // Show different buttons based on the task status
                if (task.status.toLowerCase() == 'not_started')
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: primaryColor,
                            side: BorderSide(color: secondaryColor),
                          ),
                          onPressed: controller.isLoading.value 
                            ? null 
                            : () => _handleTaskAction('accept', context),
                          child: Text(
                            "Accept".tr,
                            style: TextStyle(color: white, fontSize: baseFont),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value 
                            ? null 
                            : () => _handleTaskAction('reject', context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: Text(
                            "Reject".tr,
                            style: TextStyle(color: white, fontSize: baseFont),
                          ),
                        ),
                      ),
                    ],
                  )
                else if (task.status.toLowerCase() == 'in_progress')
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: primaryColor,
                            side: BorderSide(color: secondaryColor),
                          ),
                          onPressed: controller.isLoading.value 
                            ? null 
                            : () => _handleTaskAction('complete', context),
                          child: Text(
                            "Complete".tr,
                            style: TextStyle(color: white, fontSize: baseFont),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value 
                            ? null 
                            : () => _handleTaskAction('withdraw', context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: Text(
                            "Withdraw".tr,
                            style: TextStyle(color: white, fontSize: baseFont),
                          ),
                        ),
                      ),
                    ],
                  )
                else if (task.status.toLowerCase() == 'completed')
                  Center(
                    child: Text(
                      "Task Completed".tr,
                      style: TextStyle(
                        fontSize: baseFont,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String text,
    double fontSize,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: secondaryColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: theme.brightness == Brightness.dark
                    ? Colors.white
                    : textBlack,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}