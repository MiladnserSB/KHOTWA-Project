import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/badgets_model.dart';
import 'package:khotwa/shared/constants/base_url.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/profile/volunteer%20history/warnings_page.dart';

class VolunteerHistoryPage extends StatelessWidget {
  VolunteerHistoryPage({super.key});

  final VolunteerController controller = Get.find<VolunteerController>();

  final List<Map<String, dynamic>> dataList = [
    {
      'campaign': 'Blood Donation Drive',
      'hours': 5,
      'role': 'Organizer',
      'rate': 4.5,
      'date': '2023-06-10',
      'isCurrent': false,
    },
    {
      'campaign': 'Health Awareness Campaign',
      'hours': 3,
      'role': 'Volunteer',
      'rate': 4.8,
      'date': '2023-04-22',
      'isCurrent': false,
    },
    {
      'campaign': 'Ongoing Tree Planting',
      'hours': 2,
      'role': 'Team Member',
      'rate': 5.0,
      'date': '2025-07-01',
      'isCurrent': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalTime = dataList.fold<int>(
      0,
      (acc, item) => acc + (item['hours'] as int),
    );

    final personName = 'Ahmed Ali'.tr;
    final joinedDateText = 'Joined: March 15, 2022'.tr;
    final theme = Theme.of(context);


    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark
          ? Colors.black
          : thirdColor,
      appBar: AppBar(
        backgroundColor: theme.brightness == Brightness.dark
            ? primaryColor
            : secondaryColor,
        elevation: 0,
        leading: BackButton(
          color: theme.brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        title: Text(
          'Volunteer History'.tr,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        elevation: 6,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => WarningsPage()),
          );
        },
        child: const Icon(Icons.warning_amber_rounded, color: white, size: 28),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? thirdColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: primaryColor,
                      child: const Icon(Icons.person, color: white, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            personName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textBlack,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: secondaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Active Volunteer'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: secondaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            joinedDateText,
                            style: const TextStyle(fontSize: 12, color: grey),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "Volunteer Hours".tr,
                          style: const TextStyle(
                            color: fourthColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: primaryColor,
                          child: Text(
                            "$totalTime",
                            style: const TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              Text(
                "My Badges".tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: secondaryColor),
                  );
                }

                if (controller.myBadgets.isEmpty) {
                  return Text(
                    "No badges yet".tr,
                    style: const TextStyle(color: grey, fontSize: 14),
                  );
                }

                return SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.myBadgets.length,
                    itemBuilder: (context, index) {
                      final BadgetModel badge = controller.myBadgets[index];
                      return Container(
                        width: 110,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.dark
                              ? thirdColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: grey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(baseUrl+ badge.iconUrl),
                              backgroundColor: secondaryColor.withOpacity(0.1),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              badge.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textBlack,
                              ),
                            ),
                            Text(
                              "Level ${badge.level}",
                              style: const TextStyle(
                                fontSize: 11,
                                color: grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 32),

              Center(
                child: Text(
                  "Campaign History".tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              ...dataList
                  .map((item) => _buildCampaignCard(context, item))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignCard(BuildContext context, Map<String, dynamic> item) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? thirdColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: item['isCurrent'] ? secondaryColor : primaryColor,
          child: Text(
            item['rate'].toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: white,
              fontSize: 16,
            ),
          ),
        ),
        title: Text(
          item['campaign'],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theme.brightness == Brightness.dark
                ? primaryColor
                : primaryColor,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              "${'Role:'.tr} ${item['role']}  •  ${'Hours:'.tr} ${item['hours']}",
              style: const TextStyle(fontSize: 12, color: grey),
            ),
            const SizedBox(height: 4),
            Text(
              "${'Date:'.tr} ${item['date']}",
              style: const TextStyle(fontSize: 12, color: grey),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: item['isCurrent']
                ? secondaryColor.withOpacity(0.15)
                : primaryColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            item['isCurrent'] ? "Active".tr : "Completed".tr,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: item['isCurrent'] ? secondaryColor : primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
