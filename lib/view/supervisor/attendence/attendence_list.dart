
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/supervisor/attendence/attendence_button.dart';
import 'package:khotwa/view/supervisor/attendence/show_qr_in_page.dart';
import 'package:khotwa/view/supervisor/attendence/show_qr_out_page.dart';
import 'package:khotwa/view/supervisor/attendence/volunteer_card.dart';

class AttendanceList extends StatefulWidget {
  final bool checkIn;
  const AttendanceList({super.key,required this.checkIn});
  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
 
@override
  void initState() {
    super.initState();
  }

  final List<Map<String, dynamic>> volunteers = [
    {
      "name": "Alice Johnson",
      "role": "Event Coordinator",
      "image": "https://randomuser.me/api/portraits/women/1.jpg",
      "checked": false,
    },
    {
      "name": "Bob Williams",
      "role": "Volunteer Helper",
      "image": "https://randomuser.me/api/portraits/men/2.jpg",
      "checked": true,
    },
    {
      "name": "Charlie Brown",
      "role": "Logistics Support",
      "image": "https://randomuser.me/api/portraits/men/3.jpg",
      "checked": false,
    },
    {
      "name": "Diana Prince",
      "role": "Community Outreach",
      "image": "https://randomuser.me/api/portraits/women/4.jpg",
      "checked": true,
    },
    {
      "name": "Eve Adams",
      "role": "Guest Relations",
      "image": "https://randomuser.me/api/portraits/women/5.jpg",
      "checked": false,
    },
    {
      "name": "Frank Miller",
      "role": "Setup Crew",
      "image": "https://randomuser.me/api/portraits/men/6.jpg",
      "checked": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = MediaQuery.of(context).size.height * 0.07;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          AttendanceButton(
            label: "QR Attendance",
            icon: Icons.qr_code,
            backgroundColor: secondaryColor,
            height: buttonHeight * 0.8,
            onPressed: () { widget.checkIn ? Get.to(ShowQrInPage()) : Get.to(ShowQrOutPage());},
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: volunteers.length,
              itemBuilder: (context, index) {
                final volunteer = volunteers[index];
                return VolunteerCard(
                  name: volunteer["name"],
                  role: volunteer["role"],
                  imageUrl: volunteer["image"],
                  checked: volunteer["checked"],
                  isCheckIn: widget.checkIn,
                  onCheckChanged: (val) {
                    setState(() {
                      volunteer["checked"] = val ?? false;
                    });
                  },
                  onFeedbackPressed: () {},
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          AttendanceButton(
            label: "Submit Attendance",
            backgroundColor: primaryColor,
            height: buttonHeight,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
