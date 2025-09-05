import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/supervisor/attendence/attendence_list.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key, required this.eventId});
  final int eventId;
  @override
  Widget build(BuildContext context) {
    final double fontScale =
        MediaQuery.of(context).size.width / 375; // iPhone 11 base
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          centerTitle: true,
          title: Text(
            "Volunteer Attendance".tr,
            style: TextStyle(
              fontSize: 20 * fontScale,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          bottom: ButtonsTabBar(
            backgroundColor: primaryColor,
            unselectedBackgroundColor: grey.withOpacity(0.1),
            radius: 20,
            contentPadding: EdgeInsets.symmetric(horizontal: 42 * fontScale),
            labelStyle: TextStyle(
              color: white,
              fontWeight: FontWeight.w600,
              fontSize: 14 * fontScale,
            ),
            unselectedLabelStyle: TextStyle(
              color: textBlack,
              fontWeight: FontWeight.w600,
              fontSize: 14 * fontScale,
            ),
            tabs: [
              Tab(text: 'Check In'.tr, icon: Icon(Icons.login)),
              Tab(text: 'Check Out'.tr, icon: Icon(Icons.logout)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AttendanceList(checkIn: true, eventId: eventId), 
            AttendanceList(checkIn: false, eventId: eventId),
          ],
        ),
      ),
    );
  }
}
