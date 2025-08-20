import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/supervisor/create_task/date_picker_section.dart';

class CreateTaskPage extends StatelessWidget {
  CreateTaskPage({super.key});

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> dueDate = Rx<DateTime?>(null);

  @override
  Widget build(BuildContext context) {                        final theme = Theme.of(context); 


    return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Create New Task",
          style: TextStyle( color:   theme.brightness == Brightness.dark
            ? Colors.white
            : textBlack,),
        ),
            backgroundColor: theme.scaffoldBackgroundColor,
        iconTheme:  IconThemeData(color:   theme.brightness == Brightness.dark
            ? Colors.white
            : textBlack,),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Title',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      hintText: "Enter task name",
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      hintText: "Enter task description",
                    ),
                  ),
                  const SizedBox(height: 16),

                  DatePickerSection(
                    title: "Start Date",
                    dateVar: startDate,
                  ),
                  const SizedBox(height: 16),

                  DatePickerSection(
                    title: "Due Date",
                    dateVar: dueDate,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C261D),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  print("Task Saved");
                  print("Name: ${taskNameController.text}");
                  print("Description: ${descriptionController.text}");
                  print("Start Date: ${startDate.value}");
                  print("Due Date: ${dueDate.value}");
                },
                child: const Text(
                  "Assign",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Get.back(),
                child: const Text("Cancel", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
