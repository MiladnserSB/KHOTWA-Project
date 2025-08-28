import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/profile/profile_page_categories_info_list.dart';
import 'package:khotwa/view/profile/profile_page_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
                  final theme = Theme.of(context); 

    final isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
        backgroundColor:  theme.brightness == Brightness.dark ? Colors.black : thirdColor,

         
      body: 
      
      SafeArea(
        child: Center(
          child: ConstrainedBox(
          
            constraints: const BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children:  [
                  
                  ProfilePageHeader(),
                  SizedBox(height: 40),
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
