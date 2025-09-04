import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/maps/maps_screen.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/shared/constants/base_url.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/event_details/card_information_in_event.dart';
import 'package:khotwa/view/event_and_projects/event_details/map_location_page.dart';
import 'package:khotwa/view/event_and_projects/event_details/project_card_in_details_page.dart';
import 'package:khotwa/view/event_and_projects/scan_qr_page.dart';
import 'package:khotwa/view/login/login_page.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final volunteerController = Get.find<VolunteerController>();

    final formattedDate = DateFormat('MMMM dd, yyyy').format(event.date);

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
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : textBlack,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Event Details".tr,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : textBlack,
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
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: event.coverImage != null
                    ? Image.network(
                        event.coverImage!,
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

              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                event.description,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.brightness == Brightness.dark
                      ? Colors.white
                      : textBlack,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // Dates
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

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: CardInformationInEvent(
                        icon: Icons.access_time,
                        title: 'Time'.tr,
                        value: event.time,
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
                              center: LatLong(event.lat!, event.lng!),
                              locationName: event.location,
                              limitLocation: event.location,
                              locationPinIconColor: Colors.red,
                              eventName: event.title,
                              eventTime: event.time,
                              eventDate: event.date.toString(),
                            ),
                          );
                        },
                        child: CardInformationInEvent(
                          icon: Icons.location_on,
                          title: 'Location'.tr,
                          value: event.location,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Project card
              ProjectCard(
                size: size,
                imagePath: 'assets/images/Intro.png',
                projectName: event.projectName,
                progressPercentage: 0.68,
              ),
              const SizedBox(height: 30),

              /// 🔹 Action Button
              Obx(() {
                final isLoading = volunteerController.isLoading.value;
                final isRegistered = volunteerController.isRegisteredFor(
                  event.id,
                );

                if (roleID != 2 && roleID != 3) {
                  return const SizedBox.shrink();
                }

                String buttonText = '';
                VoidCallback? onPressed;

                // Upcoming event
                if (event.status == 'upcoming') {
                  final eventStart = DateTime(
                    event.date.year,
                    event.date.month,
                    event.date.day,
                  );
                  final now = DateTime.now();
                  final hoursUntilStart = eventStart.difference(now).inHours;

                  if (!isRegistered &&
                      event.currentVolunteers < event.requiredVolunteers) {
                    buttonText = 'Join'.tr;
                    onPressed = () =>
                        volunteerController.registerForEvent(event.id);
                  } else if (isRegistered) {
                    if (hoursUntilStart > 24) {
                      buttonText = 'Withdraw'.tr;
                      onPressed = () =>
                          volunteerController.withdrawFromEvent(event.id);
                    } else {
                      buttonText = 'Registered'.tr;
                      onPressed = null;
                    }
                  }
                }
                // Open event
                else if (event.status == 'open' && isRegistered) {
                  if (roleID == 2) {
                    buttonText = 'Scan QR'.tr;
                    onPressed = () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScanQrPage()),
                      );
                      if (result != null) {
                        final volunteerController =
                            Get.find<VolunteerController>();

                        // Example: if user has not checked in yet, do check-in
                        if (volunteerController.checkInStatus[event.id] !=
                            true) {
                          await volunteerController.handleCheckIn(
                            event.id,
                            result,
                          );
                        }
                        // If already checked in, then do check-out
                        else if (volunteerController.checkOutStatus[event.id] !=
                            true) {
                          await volunteerController.handleCheckOut(
                            event.id,
                            result,
                          );
                        } else {
                          Get.snackbar(
                            'Info',
                            'You are already checked in and checked out for this event.',
                          );
                        }
                      }
                    };
                  } else if (roleID == 3) {
                    buttonText = 'Attendance'.tr;
                    onPressed = () =>
                        Get.toNamed('/attendence_page', arguments: event);
                  }
                }

                // Closed/completed → no button
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
            ],
          ),
        ),
      ),
    );
  }
}
