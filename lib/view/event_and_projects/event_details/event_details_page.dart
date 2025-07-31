import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/event_details/project_card_in_details_page.dart';


class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Event Details",
          style: TextStyle(color: textBlack, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Header
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/logo1.png',
                  width: double.infinity,
                  height: size.height * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Title & Description
              const Text(
                "Local Community Garden Revitalization",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Join us in transforming an neglected urban space into a vibrant community garden. This project fosters local engagement, promotes sustainable living, and provides fresh produce for everyone.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // Info Cards
              Column(
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: InfoCard(
                          icon: Icons.calendar_month,
                          title: 'Start Date',
                          value: 'September 15, 2024',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InfoCard(
                          icon: Icons.calendar_today,
                          title: 'End Date',
                          value: 'October 30, 2024',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.015),
                  Row(
                    children: const [
                      Expanded(
                        child: InfoCard(
                          icon: Icons.access_time,
                          title: 'Time',
                          value: '9:00 AM - 4:00 PM\nDaily',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: InfoCard(
                          icon: Icons.location_on,
                          title: 'Location',
                          value: 'Central Park West Side',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Status & Volunteers
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "Status: Active",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.people, color: secondaryColor),
                        const SizedBox(width: 6),
                        Text(
                          '150 / 200',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              ProjectCard(
                size: MediaQuery.of(context).size,
                imagePath: 'assets/images/Intro.png',
                projectName: 'Clean Water Initiative',
                progressPercentage: 0.68,
              ),

              const SizedBox(height: 30),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                  label: const Text(
                    'Join',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    foregroundColor: white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated InfoCard with secondaryColor background
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.035),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: white),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              height: 1.3,
              color: white,
            ),
          ),
        ],
      ),
    );
  }
}
