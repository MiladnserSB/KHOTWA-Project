import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/shared/constants/colors.dart';
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
      backgroundColor:
          theme.brightness == Brightness.dark ? Colors.black : thirdColor,
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
              SizedBox(height: size.height * 0.02),

              // 🔥 Event list
              Expanded(
                child: Obx(() {
                  if (_controller.isLoading.value) {
                    return const Center(child: CustomProgressIndicator());
                  }

                  if (_controller.myEvents.isEmpty) {
                    return Center(
                      child: Text("No events found".tr,
                          style: const TextStyle(fontSize: 16)),
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
    return Row(
      children: [
        Expanded(
          child: Container(
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
                    decoration: InputDecoration(
                      hintText: "search".tr,
                      hintStyle: const TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                   (statusValues.reverse[event.status] ?? 'unknown').capitalize!,
                      style: const TextStyle(
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
                // 🔥 hook to controller.withdrawFromEvent(event.id)
                Get.find<VolunteerController>().withdrawFromEvent(event.id);
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
