import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event/date_and_time_card.dart';
import 'package:khotwa/view/event/row_information.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/logo1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Packing Food',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '140/150',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Volunteers',
                              style: TextStyle(
                                fontSize: 12,
                                color: grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: DateAndTimeCard(
                            icon: Icons.calendar_today,
                            title: 'Date',
                            value: 'Friday, Apr 08, 2023',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: DateAndTimeCard(
                            icon: Icons.access_time,
                            title: 'Time',
                            value: '10 AM - 7 PM',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    RowInformation(
                      icon: Icons.timer,
                      value: '9 hours duration',
                      color: primaryColor,
                    ),
                    SizedBox(height: 30),
                    RowInformation(
                      icon: Icons.location_on,
                      value: 'KEP - Municipality of Alimos',
                      color: primaryColor,
                    ),
                    SizedBox(height: 30),
                    RowInformation(
                      icon: Icons.assignment,
                      value: 'Project: Helping the Needy',
                      color: primaryColor,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'About the event',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Help prepare and pack meals for people in need. Tasks include ingredient sorting, portioning, and clean packaging. This volunteer role aims to support access to healthy meals for those struggling with hunger.',
                      style: TextStyle(
                        color: grey,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Apply Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



