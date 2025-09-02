import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/notifications/notifications_details_page.dart';

class NotificationsListPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      "title": "New Event Assigned",
      "description": "You’ve been added to the Health Awareness Campaign.",
      "eventName": "Health Awareness Campaign",
      "supervisor": "Dr. Sarah Lee",
      "time": "2 hrs ago",
    },
    {
      "title": "Feedback Request",
      "description": "Please provide feedback for the Community Workshop.",
      "eventName": "Community Workshop",
      "supervisor": "John Carter",
      "time": "Yesterday",
    },
    {
      "title": "Schedule Update",
      "description": "The timing for the Blood Donation Drive has changed.",
      "eventName": "Blood Donation Drive",
      "supervisor": "Dr. Ali Khan",
      "time": "Aug 28",
    },
  ];

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
          icon: Icon(Icons.arrow_back,   color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,),
        ),
        backgroundColor: theme.brightness == Brightness.dark
            ? primaryColor
            : secondaryColor,
        title: Text(
          "Notifications".tr,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600; // tablet/desktop breakpoint

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWide ? 2 : 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isWide ? 3 : 2.5,
              ),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NotificationDetailsPage(
                          title: notification["title"]!,
                          description: notification["description"]!,
                          eventName: notification["eventName"]!,
                          supervisor: notification["supervisor"]!,
                          time: notification["time"]!,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    color:   theme.brightness == Brightness.dark
                ? thirdColor
                : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification["title"]!,
                            style:  TextStyle(
                              color:    theme.brightness == Brightness.dark
                ? primaryColor
                : secondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            notification["description"]!,
                            style: const TextStyle(color: Colors.black, fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                notification["time"]!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
