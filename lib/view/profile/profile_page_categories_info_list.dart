import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/model/profile_model.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/profile/profile_category_details.dart';
import 'package:khotwa/view/profile/volunteer%20history/volunteer_history_page.dart';

class ProfilePageCategoriesInfoList extends StatelessWidget {
  final Profile profile;

  const ProfilePageCategoriesInfoList({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return buildProfileListCategories(context);
  }

  Widget buildProfileListCategories(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, String>> infoItems = [
      {'title': 'Personal Information'.tr, 'subtitle': 'Details about you'.tr},
      {'title': 'Volunteer Info'.tr, 'subtitle': 'Your volunteering details'.tr},
      {'title': 'Experience and Skills'.tr, 'subtitle': 'Your skills and experience'.tr},
      {'title': 'Emergency Contact'.tr, 'subtitle': 'Emergency contact details'.tr},
      {'title': 'Volunteer History'.tr, 'subtitle': 'History of your volunteering'.tr},
    ];

    final List<IconData> icons = [
      Icons.info_outline,
      Icons.volunteer_activism,
      Icons.star_rate,
      Icons.phone_android,
      Icons.history,
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: infoItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: GestureDetector(
            onTap: () {
              if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VolunteerHistoryPage()),
                );
              } else {
                final sectionFields = getCategoryPage(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileCategoryDetails(
                      title: infoItems[index]['title']!,
                      fields: sectionFields,
                    ),
                  ),
                );
              }
            },
            child: Card(
              color: theme.brightness == Brightness.dark ? fifth : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                leading: Icon(
                  icons[index],
                  color: theme.brightness == Brightness.dark ? Colors.white : secondaryColor,
                  size: 32,
                ),
                title: Text(
                  overflow: TextOverflow.ellipsis,
                  infoItems[index]['title']!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: theme.brightness == Brightness.dark ? Colors.white : textBlack,
                  ),
                ),
                subtitle: Text(
                  infoItems[index]['subtitle']!,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Map<String, String>> getCategoryPage(int index) {
    switch (index) {
      case 0:
        return [
          {'label': 'Full Name'.tr, 'value': profile.fullName},
          {'label': 'Email'.tr, 'value': profile.email},
          {'label': 'Phone'.tr, 'value': profile.phone},
          {'label': 'City'.tr, 'value': profile.cityId?.toString() ?? ''},
        ];
      case 1:
        return [
          {'label': 'Education Level'.tr, 'value': profile.educationLevel},
          {'label': 'University'.tr, 'value': profile.university},
          {'label': 'Total Hours'.tr, 'value': '${profile.totalVolunteerHours}'},
        ];
      case 2:
        return [
          {'label': 'Skills'.tr, 'value': profile.skills.join(", ")},
          {'label': 'Badges'.tr, 'value': profile.badges.join(", ")},
        ];
      default:
        return [];
    }
  }
}
