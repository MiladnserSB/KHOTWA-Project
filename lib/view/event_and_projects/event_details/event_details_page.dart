import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/maps/maps_screen.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_Page_Donor.dart';
import 'package:khotwa/view/event_and_projects/event_details/card_information_in_event.dart';
import 'package:khotwa/view/event_and_projects/event_details/map_location_page.dart';
import 'package:khotwa/view/event_and_projects/event_details/project_card_in_details_page.dart';
import 'package:khotwa/view/event_and_projects/scan_qr_page.dart';
import 'package:intl/intl.dart'; // For date formatting


class EventDetailsPage extends StatelessWidget {
  final EventModel event; // Add EventModel parameter

  const EventDetailsPage({super.key, required this.event}); // Update constructor

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    // Format the event date
    final formattedDate = DateFormat('MMMM/dd/yyyy').format(event.date);

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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                event.description,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      theme.brightness == Brightness.dark ? Colors.white : textBlack,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
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
                        value: formattedDate, // Use the same date if no end date
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
                        onTap: (){
                          Get.to(LocationDisplayScreen(
      center: LatLong(event.lat!, event.lng!),
      locationName: "سوريا",
      limitLocation: "سوريا",
      locationPinIconColor: Colors.red,
      eventName:event.title,
      eventTime: event.time,
      eventDate: event.date.toString(),
    ),);
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
              ProjectCard(
                size: size,
                imagePath: 'assets/images/Intro.png', // Keep default or use from event if available
                projectName: event.projectName,
                progressPercentage: 0.68, // Default value
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                  // final result = await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>  ScanQrPage()),
                    // );
                    // if (result != null) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(content: Text("Scanned QR: $result")),
                    //   );
                    
                  },
                  icon: const Icon(Icons.qr_code_scanner),
                  label: Text(
                    'Join'.tr,
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