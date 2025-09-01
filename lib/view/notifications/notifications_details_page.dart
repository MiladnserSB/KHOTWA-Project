import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';

class NotificationDetailsPage extends StatelessWidget {
  final String title;
  final String description;
  final String eventName;
  final String supervisor;
  final String time;

  const NotificationDetailsPage({
    Key? key,
    required this.title,
    required this.description,
    required this.eventName,
    required this.supervisor,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final theme = Theme.of(context);

    return Scaffold(
 backgroundColor: theme.brightness == Brightness.dark
                        ?Colors.black
                        : thirdColor,      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back, color: white,)),
        backgroundColor: primaryColor,
        title:  Text(
          "Notification Details".tr,
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 6,
            color: white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textBlack,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, color: grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.event, color: secondaryColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${'Event:'.tr} $eventName",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.person, color: secondaryColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
"${'Supervisor:'.tr} $supervisor",                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
"${'Received:'.tr} $time",                      style: const TextStyle(fontSize: 14, color: grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
