import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/supervisor_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/scan_qr_page.dart';
import 'package:khotwa/view/supervisor/attendence/attendence_button.dart';
import 'package:khotwa/view/supervisor/attendence/show_qr_in_page.dart';
import 'package:khotwa/view/supervisor/attendence/show_qr_out_page.dart';
import 'package:khotwa/view/supervisor/attendence/volunteer_card.dart';
import 'package:khotwa/model/event_registeration_model.dart';
import 'package:khotwa/widgets/custom_progress_indicator.dart';

class AttendanceList extends StatefulWidget {
  final bool checkIn;
  final int eventId;

  const AttendanceList({
    super.key,
    required this.checkIn,
    required this.eventId,
  });

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  late SupervisorController controller;

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<SupervisorController>()) {
      Get.lazyPut(() => SupervisorController());
    }

    controller = Get.find<SupervisorController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchEventRegistrations(widget.eventId, checkIn: widget.checkIn);
    });
  }

 




  @override
  Widget build(BuildContext context) {
    final double buttonHeight = MediaQuery.of(context).size.height * 0.07;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AttendanceButton(
            label: "QR Attendance".tr,
            icon: Icons.qr_code,
            backgroundColor: secondaryColor,
            height: buttonHeight * 0.8,
            onPressed: () async {
              await controller.generateEventQR(widget.eventId, widget.checkIn);
            },
          ),
          const SizedBox(height: 16),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CustomProgressIndicator());
              }
              if (controller.eventRegistrations.isEmpty) {
                return Center(
                  child: Text(
                    "No volunteers registered".tr,
                    style: const TextStyle(color: grey),
                  ),
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.eventRegistrations.length,
                itemBuilder: (context, index) {
                  final EventRegistration eventRegistration =
                      controller.eventRegistrations[index];

                  return VolunteerCard(
                    name: eventRegistration.volunteer.fullName ?? "-",
                    role: 'Volunteer',
                    imageUrl: eventRegistration.volunteer.profileImageUrl ?? "",
                    checked: eventRegistration.isSelected ?? false,
                    isCheckIn: widget.checkIn,
                    onCheckChanged: (val) {
                      controller.eventRegistrations[index] = eventRegistration
                          .copyWith(isSelected: val ?? false);
                    },
                    onFeedbackPressed: () {},
                  );
                },
              );
            }),
          ),

          const SizedBox(height: 12),

          AttendanceButton(
            label: "Submit Attendance".tr,
            backgroundColor: primaryColor,
            height: buttonHeight,
            onPressed: () async {
              final selectedIds = controller.eventRegistrations
                  .where((reg) => reg.isSelected == true)
                  .map((reg) => reg.volunteerId)
                  .toList();

              if (selectedIds.isEmpty) {
                Get.snackbar("Error", "Please select at least one volunteer");
                return;
              }

              if (widget.checkIn) {
                await controller.manualCheckIn(widget.eventId, selectedIds);
              } else {
                await controller.manualCheckOut(widget.eventId, selectedIds);
              }
            },
          ),
        ],
      ),
    );
  }
}


