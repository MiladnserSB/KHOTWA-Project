import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/supervisor/attendence/attendence_list.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double fontScale = MediaQuery.of(context).size.width / 375; // iPhone 11 base
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          centerTitle: true,
          title: Text(
            "Volunteer Attendance",
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
            tabs: const [
              Tab(text: 'Check In', icon: Icon(Icons.login)),
              Tab(text: 'Check Out', icon: Icon(Icons.logout)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AttendanceList(checkIn: true,),
            AttendanceList(checkIn: false,),
          ],
        ),
      ),
    );
  }
}
