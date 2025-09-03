import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/profile/profile_page_categories_info_list.dart';
import 'package:khotwa/view/profile/profile_page_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final VolunteerController controller = Get.find<VolunteerController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile".tr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: theme.brightness == Brightness.dark ? primaryColor : secondaryColor,
        centerTitle: true,
        elevation: 0,
        leading: BackButton(
          color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor: theme.brightness == Brightness.dark ? Colors.black : thirdColor,
      body: Obx(() {
        if (controller.isProfileLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.profile.value == null) {
          return Center(child: Text("Failed to load profile".tr));
        }

        return SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    ProfilePageHeader(profile: controller.profile.value!.data),
                    const SizedBox(height: 40),
                    ProfilePageCategoriesInfoList(profile: controller.profile.value!.data),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
