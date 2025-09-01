import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/donate_apologize_button.dart';
import 'package:khotwa/view/event_and_projects/event_details/event_details_page.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({super.key});

  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
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

  double _calculateScale(int index, double itemHeight) {
    double itemOffset = index * (itemHeight + 20);
    double diff = (itemOffset - currentScroll).abs();
    double scale = 1 - (diff / (itemHeight * 4));
    return scale.clamp(0.9, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double itemHeight = size.height * 0.38;
              final theme = Theme.of(context); 

    return Scaffold(
        backgroundColor:  theme.brightness == Brightness.dark ? Colors.black : thirdColor,

      body: SafeArea(
        
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.02),
              Center(
                child: Text(
                  'my events'.tr,
                  style: TextStyle(
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(Icons.search,color: Colors.black,),
                                                    SizedBox(width: 10),

                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                counterStyle: TextStyle(color: Colors.black),
                                hintText: "search".tr,
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
               
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    double scale = _calculateScale(index, itemHeight);
                    return Transform.scale(
                      scale: scale,
                      child: GestureDetector(
                         onTap: (){Get.to(EventDetailsPage());},
                        child: EventCard(
                          size: size,
                          elevation: scale > 0.98 ? 10 : 2,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.size, this.elevation = 2});

  final Size size;
  final double elevation;

  @override
  Widget build(BuildContext context) {
                            final theme = Theme.of(context); 

    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/Intro.png',
                height: size.height * 0.2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Event Title Goes Here',
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Acumin',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Text(
                      'Active'.tr,
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.015,
              ),
              child: Column(
                children:  [
                  InfoRow(
                    icon: Icons.calendar_today,
                    label: "Date".tr,
                    value: "16.04.2024 - 16.08.2024",
                  ),
                  InfoRow(
                    icon: LucideIcons.clock,
                    label: "Time".tr,
                    value: "10:00 AM - 4:00 PM",
                  ),
                  InfoRow(
                    icon: Icons.location_on,
                    label: "Location".tr,
                    value: "Kharkiv, Ukraine",
                  ),
                  InfoRow(
                    icon: Icons.volunteer_activism,
                    label: "Volunteers".tr,
                    value: "150 / 200",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            DonateApologizeButton(
              title: 'Apologize'.tr,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final size = MediaQuery.of(context).size;
                    return Dialog(
                  backgroundColor: theme.brightness == Brightness.dark
                        ? Color(0xFF202020)
                        : thirdColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(size.width * 0.06),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                size: size.width * 0.15, color: secondaryColor),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'Apology Confirmation'.tr,
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color:  theme.brightness == Brightness.dark ? Colors.white : Colors.black, // Scaffold

                              ),
                            ),
                            SizedBox(height: size.height * 0.015),
                            Text(
                              'Are you sure you want to apologize for the event'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
 color:   theme.brightness == Brightness.dark
            ? Colors.grey
            : Colors.grey,                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text('Cancel'.tr,
                                        style: TextStyle(color: white, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                SizedBox(width: size.width * 0.03),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      // Apologize logic goes here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: secondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text('Apologize'.tr,
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
      child: Row(
        children: [
          Icon(icon, size: size.width * 0.05, color: Colors.white),
          SizedBox(width: size.width * 0.03),
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.04,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: size.width * 0.038,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
