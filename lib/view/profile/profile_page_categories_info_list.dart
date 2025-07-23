import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/profile/info_section_page.dart';
import 'package:khotwa/view/profile/volunteer%20history/volunteer_history_page.dart';

class ProfilePageCategoriesInfoList extends StatelessWidget {
  const ProfilePageCategoriesInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildInfoList(context);
  }

  Widget _buildInfoList(BuildContext context) {
    final List<Map<String, String>> infoItems = [
      {'title': 'Personal Information', 'subtitle': 'Details about you'},
      {'title': 'Volunteer Info', 'subtitle': 'Your volunteering details'},
      {'title': 'Experience and Skills', 'subtitle': 'Your skills and experience'},
      {'title': 'Emergency Contact', 'subtitle': 'Emergency contact details'},
      {'title': 'Volunteer History', 'subtitle': 'History of your volunteering'},
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
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: GestureDetector(
            onTap: () {
              if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>  VolunteerHistoryPage()),
                );
              } else {
                final sectionFields = _getFieldsForIndex(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InfoSectionPage(
                      title: infoItems[index]['title']!,
                      fields: sectionFields,
                    ),
                  ),
                );
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              shadowColor: Colors.black12,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                leading: Icon(
                  icons[index],
                  color: primaryColor,
                  size: 26,
                ),
                title: Text(
                  overflow: TextOverflow.ellipsis,
                  infoItems[index]['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: textBlack,
                  ),
                ),
                subtitle: Text(
                  infoItems[index]['subtitle']!,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getFieldsForIndex(int index) {
    switch (index) {
      case 0:
        return [
          {'label': 'Full Name', 'value': 'John Doe'},
          {'label': 'Gender', 'value': 'Male'},
          {'label': 'Email', 'value': 'john@example.com'},
          {'label': 'Phone', 'value': '+963********'},
          {'label': 'Birth Date', 'value': '1998-04-23'},
          {'label': 'Address', 'value': 'Jaramana, AlWehda'},
          {'label': 'City', 'value': 'Rural Damascus'},
        ];
      case 1:
        return [
          {'label': 'Areas of Interest', 'value': 'Health, Education'},
          {'label': 'Availability', 'value': 'Mon, Wed, Fri'},
          {'label': 'Preferred Time', 'value': '5-8 hours/week'},
        ];
      case 2:
        return [
          {'label': 'Previous Experience', 'value': 'Blood donation volunteer'},
          {'label': 'Skills', 'value': 'First aid, Event organizing'},
          {'label': 'Motivation', 'value': 'Helping my community'},
        ];
      case 3:
        return [
          {'label': 'Contact Name', 'value': 'Jane Doe'},
          {'label': 'Relationship', 'value': 'Sister'},
          {'label': 'Phone', 'value': '+963-999999'},
        ];
      default:
        return [];
    }
  }
}
