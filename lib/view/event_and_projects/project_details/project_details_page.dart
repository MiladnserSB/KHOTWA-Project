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
    final double itemOffset = index * (itemWidth + 16); // 16 is separator
    final double diff = (itemOffset - currentScroll).abs();
    double scale = 1 - (diff / (itemWidth * 2));
    return scale.clamp(0.9, 0.99);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemWidth = size.width * 0.75;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Project Details',
          style: TextStyle(color: textBlack, fontWeight: FontWeight.bold),
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
            const Text(
              "Local Community Garden Revitalization",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Join us in transforming a neglected urban space into a vibrant community garden. This project fosters local engagement, promotes sustainable living, and provides fresh produce for everyone.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: const [
                Expanded(
                  child: EventCardInformation(
                    icon: Icons.calendar_month,
                    title: 'Start Date',
                    value: 'September 15, 2024',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: EventCardInformation(
                    icon: Icons.calendar_today,
                    title: 'End Date',
                    value: 'October 30, 2024',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
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
            ),
            const SizedBox(height: 24),
            const Text(
              "Upcoming Events",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textBlack,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: size.height * 0.5,
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
            const SizedBox(height: 24),
            const Text(
              "Donation Progress",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textBlack,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: 0.75,
                minHeight: 12,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 22, 70, 26)),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Collected: \$7,500", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600)),
                Text("Target: \$10,000", style: TextStyle(color: secondaryColor, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Donate Now",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: white),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
