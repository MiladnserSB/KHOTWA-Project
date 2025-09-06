import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/Search_controller.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Search/Search_results_page.dart';
import 'package:khotwa/view/event_and_projects/calender_page.dart';
import 'package:khotwa/view/event_and_projects/donate_apologize_button.dart';
import 'package:khotwa/view/event_and_projects/event_details/event_details_page.dart';
import 'package:khotwa/widgets/custom_progress_indicator.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({super.key});

  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  final ScrollController _scrollController = ScrollController();
  final VolunteerController _controller = Get.find<VolunteerController>();

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
      backgroundColor: theme.brightness == Brightness.dark
          ? Colors.black
          : thirdColor,
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
              // 🔍 search bar
              _buildSearchBar(size),
    SizedBox(height: size.height * 0.015),

    Align(
      alignment: Alignment.center,
      child: ElevatedButton.icon(
  onPressed: () {
    Get.to(MyEventsCalendarPage());
  },
  icon: const Icon(Icons.calendar_today, size: 18,color: Colors.white,),
  label:  Text(
    "View Events Date in Calendar".tr,
    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFDDA15E),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 6,
    shadowColor: Colors.orangeAccent,
  ).copyWith(
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.orange.withOpacity(0.2);
        }
        return null;
      },
    ),
  ),
)

    ),

    SizedBox(height: size.height * 0.015),

              Expanded(
                child: Obx(() {
                  if (_controller.isLoading.value) {
                    return const Center(child: CustomProgressIndicator());
                  }

                  if (_controller.myEvents.isEmpty) {
                    return Center(
                      child: Text(
                        "No events found".tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  return ListView.separated(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _controller.myEvents.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final event = _controller.myEvents[index] as EventModel;
                      double scale = _calculateScale(index, itemHeight);

                      return Transform.scale(
                        scale: scale,
                        child: GestureDetector(
                          onTap: () => Get.to(EventDetailsPage(event: event)),
                          child: EventCard(
                            size: size,
                            event: event,
                            elevation: scale > 0.98 ? 10 : 2,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.black),
              onChanged: (value) {
                final searchController = Get.isRegistered<AppSearchController>()
                    ? Get.find<AppSearchController>()
                    : Get.put(AppSearchController());

                searchController.searchMyEvents(value);
              },
              onSubmitted: (value) {
                Get.to(() => SearchResultsPage());
              },
              decoration: InputDecoration(
                hintText: 'search'.tr,
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }



  
}

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.size,
    required this.event,
    this.elevation = 2,
  });

  final Size size;
  final EventModel event;
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
              child: event.coverImage != null
                  ? Image.network(
                      event.coverImage!,
                      height: size.height * 0.2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
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
                      event.title,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Acumin',
                      ),
                      overflow: TextOverflow.ellipsis,
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
                    child: Text(
                      (statusValues.reverse[event.status] ?? 'unknown')
                          .capitalize!,
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
                children: [
                  InfoRow(
                    icon: Icons.calendar_today,
                    label: "Date".tr,
                    value:
                        "${event.date.toLocal().toString().split(' ')[0]} (${event.durationHours}h)",
                      
                  ),
                  InfoRow(
                    icon: LucideIcons.clock,
                    label: "Time".tr,
                    value: event.time,
                  ),
                  InfoRow(
                    icon: Icons.location_on,
                    label: "Location".tr,
                    value: event.location,
                  ),
                  InfoRow(
                    icon: Icons.volunteer_activism,
                    label: "Volunteers".tr,
                    value:
                        "${event.currentVolunteers} / ${event.requiredVolunteers}",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
    DonateApologizeButton(
  title: 'Apologize'.tr,
  onTap: () {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: theme.brightness == Brightness.dark
            ? sixth
            : thirdColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Confirm'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Are you sure you want to apologize for the event'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color:Colors.grey
                      
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDDA15E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                                       onPressed: () => Navigator.of(ctx).pop(),

                    child: Text(
                      'No'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDDA15E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Get.find<VolunteerController>()
                          .withdrawFromEvent(event.id);
                    },
                    child: Text(
                      'Yes'.tr,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
          Expanded(
            child: Text(
              "$label: $value",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.04,
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

