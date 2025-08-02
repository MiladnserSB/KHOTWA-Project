import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';
import 'package:khotwa/view/event_and_projects/project_details/event_card_information.dart';

class ProjectDetailsPage extends StatefulWidget {
  const ProjectDetailsPage({super.key});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  double currentScroll = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        currentScroll = _scrollController.offset;
      });
    });
  }

  double _calculateScale(int index, double itemWidth) {
    final double itemOffset = index * (itemWidth + 16);
    final double diff = (itemOffset - currentScroll).abs();
    double scale = 1 - (diff / (itemWidth * 2));
    return scale.clamp(0.9, 0.99);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleFactor = size.width / 375; // base width = iPhone 11
    final itemWidth = size.width * 0.75;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Project Details',
          style: TextStyle(
            color: textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 18 * scaleFactor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/logo1.png',
                width: double.infinity,
                height: size.height * 0.25,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "Local Community Garden Revitalization",
              style: TextStyle(
                fontSize: 20 * scaleFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "Join us in transforming a neglected urban space into a vibrant community garden. This project fosters local engagement, promotes sustainable living, and provides fresh produce for everyone.",
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              children: [
                Expanded(
                  child: EventCardInformation(
                    icon: Icons.calendar_month,
                    title: 'Start Date',
                    value: 'September 15, 2024',
                    fontScale: scaleFactor,
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Expanded(
                  child: EventCardInformation(
                    icon: Icons.calendar_today,
                    title: 'End Date',
                    value: 'October 30, 2024',
                    fontScale: scaleFactor,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    "Status: Active",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                      fontSize: 14 * scaleFactor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Upcoming Events",
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.bold,
                color: textBlack,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            SizedBox(
              height: size.height * 0.45,
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final scale = _calculateScale(index, itemWidth);
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1.0, end: scale),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: size.height * 0.4,
                          width: itemWidth,
                          child: Material(
                            elevation: value > 0.98 ? 10 : 2,
                            borderRadius: BorderRadius.circular(24),
                            child: EventCard(
                              size: Size(itemWidth, size.height * 0.5),
                              elevation: 0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Donation Progress",
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.bold,
                color: textBlack,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: 0.75,
                minHeight: 12,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 22, 70, 26),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Collected: \$7,500",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14 * scaleFactor,
                  ),
                ),
                Text(
                  "Target: \$10,000",
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14 * scaleFactor,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Donate Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16 * scaleFactor,
                    color: white,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
