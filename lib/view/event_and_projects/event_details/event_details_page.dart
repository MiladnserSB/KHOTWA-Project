import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/maps/maps_screen.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/event_evaluations_model.dart';
import 'package:khotwa/shared/constants/base_url.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/event_details/card_information_in_event.dart';
import 'package:khotwa/view/event_and_projects/event_details/map_location_page.dart';
import 'package:khotwa/view/event_and_projects/event_details/project_card_in_details_page.dart';

class EventDetailsPage extends StatefulWidget {
  final EventModel event;

  const EventDetailsPage({super.key, required this.event});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final VolunteerController volunteerController = Get.find<VolunteerController>();

  final TextEditingController _commentController = TextEditingController();
  int _selectedRating = 0;

  @override
  void initState() {
    super.initState();
    volunteerController.fetchEventFeedback(widget.event.id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final formattedDate = DateFormat('MMMM dd, yyyy').format(widget.event.date);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark
          ? theme.scaffoldBackgroundColor
          : thirdColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.brightness == Brightness.dark
            ? theme.scaffoldBackgroundColor
            : thirdColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.brightness == Brightness.dark ? Colors.white : textBlack,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Event Details".tr,
          style: TextStyle(
            color: theme.brightness == Brightness.dark ? Colors.white : textBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Cover Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: widget.event.coverImage != null
                    ? Image.network(
                        widget.event.coverImage!,
                        width: double.infinity,
                        height: size.height * 0.25,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              'assets/images/logo1.png',
                              width: double.infinity,
                              height: size.height * 0.25,
                              fit: BoxFit.cover,
                            ),
                      )
                    : Image.asset(
                        'assets/images/logo1.png',
                        width: double.infinity,
                        height: size.height * 0.25,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(height: 16),

              /// 🔹 Title
              Text(
                widget.event.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              /// 🔹 Description
              Text(
                widget.event.description,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.brightness == Brightness.dark ? Colors.white : textBlack,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              /// 🔹 Dates
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: CardInformationInEvent(
                        icon: Icons.calendar_month,
                        title: 'Start Date'.tr,
                        value: formattedDate,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: CardInformationInEvent(
                        icon: Icons.calendar_today,
                        title: 'End Date'.tr,
                        value: formattedDate,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.015),

              /// 🔹 Time + Location
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: CardInformationInEvent(
                        icon: Icons.access_time,
                        title: 'Time'.tr,
                        value: widget.event.time,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            LocationDisplayScreen(
                              center: LatLong(widget.event.lat!, widget.event.lng!),
                              locationName: widget.event.location,
                              limitLocation: widget.event.location,
                              locationPinIconColor: Colors.red,
                              eventName: widget.event.title,
                              eventTime: widget.event.time,
                              eventDate: widget.event.date.toString(),
                            ),
                          );
                        },
                        child: CardInformationInEvent(
                          icon: Icons.location_on,
                          title: 'Location'.tr,
                          value: widget.event.location,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              /// 🔹 Project Card
              ProjectCard(
                size: size,
                imagePath: 'assets/images/Intro.png',
                projectName: widget.event.projectName,
                progressPercentage: 0.68,
              ),
              const SizedBox(height: 30),

              /// 🔹 Join / Withdraw button
              Obx(() {
                final isLoading = volunteerController.isLoading.value;
                final isRegistered = volunteerController.isRegisteredFor(widget.event.id);

                if (roleID != 2 && roleID != 3) {
                  return const SizedBox.shrink();
                }

                String buttonText = '';
                VoidCallback? onPressed;

                if (widget.event.status == 'upcoming') {
                  final eventStart = DateTime(
                    widget.event.date.year,
                    widget.event.date.month,
                    widget.event.date.day,
                  );
                  final now = DateTime.now();
                  final hoursUntilStart = eventStart.difference(now).inHours;

                  if (!isRegistered &&
                      widget.event.currentVolunteers < widget.event.requiredVolunteers) {
                    buttonText = 'Join'.tr;
                    onPressed = () => volunteerController.registerForEvent(widget.event.id);
                  } else if (isRegistered) {
                    if (hoursUntilStart > 24) {
                      buttonText = 'Withdraw'.tr;
                      onPressed = () =>
                          volunteerController.withdrawFromEvent(widget.event.id);
                    } else {
                      buttonText = 'Registered'.tr;
                    }
                  }
                } else if (widget.event.status == 'open' && isRegistered) {
                  if (roleID == 2) {
                    buttonText = 'Scan QR'.tr;
                     // onPressed = () async {
                    //   final result = await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => ScanQrPage()),
                    //   );
                    //   if (result != null) {
                    //     final volunteerController =
                    //         Get.find<VolunteerController>();

                    //     if (volunteerController.checkInStatus[event.id] !=
                    //         true) {
                    //       await volunteerController.handleCheckIn(
                    //         event.id,
                    //         result,
                    //       );
                    //     }
                    //     else if (volunteerController.checkOutStatus[event.id] !=
                    //         true) {
                    //       await volunteerController.handleCheckOut(
                    //         event.id,
                    //         result,
                    //       );
                    //     } else {
                    //       Get.snackbar(
                    //         'Info',
                    //         'You are already checked in and checked out for this event.',
                    //       );
                    //     }
                    //   }
                    // };
                  } else if (roleID == 3) {
                    buttonText = 'Attendance'.tr;
                    onPressed = () => Get.toNamed('/attendence_page', arguments: widget.event);
                  }
                }

                if (buttonText.isEmpty) return const SizedBox.shrink();

                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      foregroundColor: white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: white)
                        : Text(
                            buttonText,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                );
              }),

              const SizedBox(height: 30),

              /// 🔹 Feedback Section
              Text(
                "Feedback".tr,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              /// Show feedback
              Obx(() {
                if (volunteerController.isFeedbackLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: secondaryColor));
                }

                final feedback = volunteerController.eventFeedback.value;
                if (feedback == null) {
                  return Text("No feedback yet".tr);
                }

                return Card(
                  color: theme.cardColor,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(feedback.volunteer.name,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < feedback.rating ? Icons.star : Icons.star_border,
                              color: secondaryColor,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(feedback.comment),
                        const SizedBox(height: 6),
                        Text(
                          DateFormat.yMMMd().format(feedback.createdAt),
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              /// 🔹 Add Feedback
              Text(
                "Add Your Feedback".tr,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              /// Rating stars
              Row(
                children: List.generate(
                  5,
                  (i) => IconButton(
                    onPressed: () {
                      setState(() => _selectedRating = i + 1);
                    },
                    icon: Icon(
                      i < _selectedRating ? Icons.star : Icons.star_border,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),

              /// Comment box
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: "Write a comment...".tr,
                  filled: true,
                  fillColor: theme.cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedRating == 0 || _commentController.text.isEmpty) {
                      Get.snackbar("Error".tr, "Please provide rating and comment".tr);
                      return;
                    }
                    await volunteerController.submitEventFeedback(
                      widget.event.id,
                      _selectedRating,
                      _commentController.text,
                    );
                    _commentController.clear();
                    setState(() => _selectedRating = 0);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    foregroundColor: white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Submit Feedback".tr),
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
