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

List<Map<String, dynamic>> getCategoryPage(int index) {
  switch (index) {
    case 0: // Personal Info
      return [
        {'label': 'Full Name'.tr, 'key': 'full_name', 'value': profile.fullName},
        {'label': 'Email'.tr, 'key': 'email', 'value': profile.email},
        {'label': 'Phone'.tr, 'key': 'phone', 'value': profile.phone},
        {
          'label': 'Gender'.tr,
          'key': 'gender',
          'value': profile.gender,
          'type': 'select',
          'options': ['male', 'female']
        },
        {'label': 'Birth Date'.tr, 'key': 'date_of_birth', 'value': profile.birthDate},
        {'label': 'City'.tr, 'key': 'city', 'value': profile.city ?? ''},
        {'label': 'Address'.tr, 'key': 'address', 'value': profile.address},
        {'label': 'Study'.tr, 'key': 'study', 'value': profile.educationLevel},
        {'label': 'Career'.tr, 'key': 'career', 'value': profile.university},
      ];

    case 1: // Volunteer Info
      return [
        {'label': 'Interests'.tr, 'key': 'interests', 'value': profile.interests.join(", ")},
        {'label': 'Availability'.tr, 'key': 'availability', 'value': profile.availability.join(", ")},
        {
          'label': 'Preferred Time'.tr,
          'key': 'preferred_time',
          'value': profile.preferredTime,
          'type': 'select',
          'options': [
            '1-2 hours per week',
            '3-5 hours per week',
            '6-10 hours per week',
            'more than 10 hours per week'
          ]
        },
        {'label': 'Volunteer Years'.tr, 'key': 'volunteering_years', 'value': '${profile.volunteeringYears}'},
      ];

    case 2: // Experience & Skills
      return [
        {'label': 'Motivation'.tr, 'key': 'motivation', 'value': profile.motivation},
        {
          'label': 'Skills'.tr,
          'key': 'skills',
          'value': profile.skills.join(", "),
          'type': 'multiselect',
          'options': [
            'Teamwork',
            'Communication',
            'Leadership',
            'Problem Solving',
            'Creativity',
            'Event Planning',
            'First Aid',
            'Technical Support',
            'Project Management'
          ]
        },
      ];

    case 3: // Emergency Contact
      return [
        {'label': 'Name'.tr, 'key': 'emergency_contact_name', 'value': profile.emergencyContactName},
        {'label': 'Phone'.tr, 'key': 'emergency_contact_phone', 'value': profile.emergencyContactPhone},
        {
          'label': 'Relationship'.tr,
          'key': 'emergency_contact_relationship',
          'value': profile.emergencyContactRelationship,
          'type': 'select',
          'options': ['Parent', 'Spouse', 'Friend']
        },
      ];

    default:
      return [];
  }
}

}