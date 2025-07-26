import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/profile/profile_page_categories_info_list.dart';
import 'package:khotwa/view/profile/profile_page_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: isLargeScreen ? 1 : 0,
        leading: const BackButton(color: textBlack),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: const [
                  ProfilePageHeader(),
                  SizedBox(height: 12),
                  ProfilePageCategoriesInfoList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
