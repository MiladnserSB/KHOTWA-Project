import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/profile/profile_category_details.dart';

class ProfilePageCategoriesInfoList extends StatelessWidget {
  const ProfilePageCategoriesInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return buildProfileListCategories(context);
  }

  Widget buildProfileListCategories(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, String>> infoItems = [
      {'title': 'Personal Information'.tr, 'subtitle': 'Details about you'.tr},
      {'title': 'Volunteer Info'.tr, 'subtitle': 'Your volunteering details'.tr},
      {
        'title': 'Experience and Skills'.tr,
        'subtitle': 'Your skills and experience'.tr,
      },
      {
        'title': 'Emergency Contact'.tr,
        'subtitle': 'Emergency contact details'.tr,
      },
      {
        'title': 'Volunteer History'.tr,
        'subtitle': 'History of your volunteering'.tr,
      },
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => VolunteerHistoryPage()),
                // );
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
              color: theme.brightness == Brightness.dark
                  ? fifth 
                  : Colors.white,

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
                  color:            theme.brightness == Brightness.dark
                        ? Colors.white
                        : secondaryColor,
                  size: 32,
                ),
                title: Text(
                  overflow: TextOverflow.ellipsis,
                  infoItems[index]['title']!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: theme.brightness == Brightness.dark
                        ? Colors.white
                        : textBlack,
                  ),
                ),
                subtitle: Text(
                  infoItems[index]['subtitle']!,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size:15 ,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
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
          {'label': 'Full Name'.tr, 'value': 'John Doe'},
          {'label': 'Gender'.tr, 'value': 'Male'},
          {'label': 'Email'.tr, 'value': 'john@example.com'},
          {'label': 'Phone'.tr, 'value': '+963********'},
          {'label': 'Birth Date'.tr, 'value': '1998-04-23'},
          {'label': 'Address'.tr, 'value': 'Jaramana, AlWehda'},
          {'label': 'City'.tr, 'value': 'Rural Damascus'},
        ];
      case 1:
        return [
          {'label': 'Areas of Interest'.tr, 'value': 'Health, Education'},
          {'label': 'Availability'.tr, 'value': 'Mon, Wed, Fri'},
          {'label': 'Preferred Time'.tr, 'value': '5-8 hours/week'},
        ];
      case 2:
        return [
          {
            'label': 'Previous Experience'.tr,
            'value': 'Blood donation volunteer',
          },
          {'label': 'Skills'.tr, 'value': 'First aid, Event organizing'},
          {'label': 'Motivation'.tr, 'value': 'Helping my community'},
        ];
      case 3:
        return [
          {'label': 'Contact Name'.tr, 'value': 'Jane Doe'},
          {'label': 'Relationship'.tr, 'value': 'Sister'},
          {'label': 'Phone', 'value'.tr: '+963-999999'},
        ];
      default:
        return [];
    }
  }
}
