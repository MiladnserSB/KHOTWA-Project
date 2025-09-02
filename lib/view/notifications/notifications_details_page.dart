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
          ? Colors.black
          : thirdColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color:    theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,),
        ),
        backgroundColor:   theme.brightness == Brightness.dark
                ? primaryColor
                : secondaryColor,
        title: Text(
          "Notification Details".tr,
          style: TextStyle(color:    theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 6,
            color:     theme.brightness == Brightness.dark
                ? thirdColor
                : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:  TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color:     theme.brightness == Brightness.dark
                ? primaryColor
                : secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                       Icon(Icons.event, color:   theme.brightness == Brightness.dark
                ? primaryColor
                : secondaryColor,size: 25,),
                      const SizedBox(width: 2),
                      Text(
                          "${'Event:'.tr} $eventName",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textBlack,
                          ),
                        ),
                      
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                       Icon(Icons.person, color:   theme.brightness == Brightness.dark
                ? primaryColor
                : secondaryColor,size: 25,),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${'Supervisor:'.tr} $supervisor",
                          style: const TextStyle(
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
                      "${'Received:'.tr} $time",
                      style: const TextStyle(fontSize: 14, color: grey),
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
