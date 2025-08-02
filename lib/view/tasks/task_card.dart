import 'package:flutter/material.dart';
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
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title, style: const TextStyle(color: textBlack)),
        content: Text(content, style: const TextStyle(color: textBlack)),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: grey,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
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
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

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
        child: LayoutBuilder(builder: (context, constraints) {
          double baseFont = constraints.maxWidth * 0.045;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: baseFont + 2,
                      fontWeight: FontWeight.bold,
                      color: textBlack)),
              const SizedBox(height: 8),
              Text(description,
                  style: TextStyle(fontSize: baseFont, color: grey)),
              const SizedBox(height: 12),
              _infoRow(Icons.calendar_today, "Assigned: $assignedDate", baseFont),
              _infoRow(Icons.event, "Due: $dueDate", baseFont),
              _infoRow(Icons.location_on_outlined, "Event: $eventName", baseFont),
              _infoRow(Icons.person, "Supervisor: $supervisorName", baseFont),
              const SizedBox(height: 10),
              Chip(
                label: Text(status),
                backgroundColor: statusColor.withOpacity(0.1),
                labelStyle: TextStyle(color: statusColor, fontSize: baseFont),
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
                          "Update Status",
                          "Are you sure you want to update the task status?",
                          () {
                            // handle update
                          },
                        );
                      },
                      child: Text("Update Status",
                          style: TextStyle(color: white, fontSize: baseFont)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showConfirmationDialog(
                          context,
                          "Decline Task",
                          "Are you sure you want to decline this task?",
                          () {
                            // handle decline
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: Text("Decline Task",
                          style: TextStyle(color: white, fontSize: baseFont)),
                    ),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, double fontSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: secondaryColor),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: textBlack, fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}
