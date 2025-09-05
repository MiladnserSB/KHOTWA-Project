import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';

class WarningsPage extends StatelessWidget {
  WarningsPage({super.key});

  final VolunteerController controller = Get.find<VolunteerController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          theme.brightness == Brightness.dark ? Colors.black : thirdColor,
      appBar: AppBar(
        backgroundColor:
            theme.brightness == Brightness.dark ? primaryColor : secondaryColor,
        elevation: 0,
        title: Text(
          "Warnings".tr,
          style: TextStyle(
            color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isVolunteerLogLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: secondaryColor),
          );
        }

        if (controller.warnings.isEmpty) {
          return Center(
            child: Text(
              "No warnings yet".tr,
              style: const TextStyle(color: grey, fontSize: 14),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.warnings.length,
          itemBuilder: (context, index) {
            final warningEval = controller.warnings[index];
            final warning = warningEval.warning;

            return Card(
              color: theme.brightness == Brightness.dark ? thirdColor : Colors.white,
              elevation: 6,
              shadowColor: Colors.red.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      warning?.reason ?? "N/A",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 18, color: primaryColor),
                        const SizedBox(width: 6),
                        Text(
                          
                          "${'Supervisor:'.tr} ${warningEval.supervisor!.name ?? "N/A"}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.event, size: 18, color: secondaryColor),
                        const SizedBox(width: 6),
                        Text(
                          "${'Event:'.tr} ${warningEval.event!.title ?? "N/A"}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
