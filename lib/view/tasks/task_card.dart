import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String assignedDate;
  final String dueDate;
  final String eventName;
  final String supervisorName;
  final String status;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.assignedDate,
    required this.dueDate,
    required this.eventName,
    required this.supervisorName,
    required this.status,
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
                : primaryColor,
          ),
        ),
        content: Text(
          content,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : primaryColor,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: grey),
            onPressed: () => Navigator.pop(context),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color statusColor;
    switch (status.toLowerCase()) {
      case 'in progress':
        statusColor = Colors.green;
        break;
      case 'pending':
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
                  title,
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
                  description,
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
                  "${'Assigned'.tr}: $assignedDate",
                  baseFont,
                  theme,
                ),
                _infoRow(Icons.event, "${'Due'.tr}: $dueDate", baseFont, theme),
                _infoRow(
                  Icons.location_on_outlined,
                  "${'Event'.tr}: $eventName",
                  baseFont,
                  theme,
                ),
                _infoRow(
                  Icons.person,
                  "${'Supervisor'.tr}: $supervisorName",
                  baseFont,
                  theme,
                ),

                const SizedBox(height: 10),
                Chip(
                  label: Text(
                    status,
                    style: TextStyle(fontSize: baseFont, color: statusColor),
                  ),
                  backgroundColor: statusColor.withOpacity(0.1),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: primaryColor,
                          side: BorderSide(color: secondaryColor),
                        ),
                        onPressed: () {
                          _showConfirmationDialog(
                            context,
                            "Update Status".tr,
                            "Are you sure you want to update the task status?"
                                .tr,
                            () {
                              // handle update
                            },
                          );
                        },
                        child: Text(
                          "Update Status".tr,
                          style: TextStyle(color: white, fontSize: baseFont),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showConfirmationDialog(
                            context,
                            "Decline Task".tr,
                            "Are you sure you want to decline this task?".tr,
                            () {
                              // handle decline
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: Text(
                          "Decline Task".tr,
                          style: TextStyle(color: white, fontSize: baseFont),
                        ),
                      ),
                    ),
                  ],
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
