import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Cards/donor_login_dialog.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';
import 'package:khotwa/view/event_and_projects/project_details/event_card_information.dart';
import 'package:khotwa/model/projects_model.dart'; // Import your ProjectModel
import 'package:intl/intl.dart';

class ProjectDetailsPage extends StatefulWidget {
  final ProjectModel project; // Add ProjectModel parameter

  const ProjectDetailsPage({
    super.key,
    required this.project,
  }); // Update constructor

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

  String _formatDate(DateTime date) {
    return DateFormat('MMMM/dd/yyyy').format(date);
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case "open":
        return 'Open'.tr;
      case "closed":
        return 'Closed'.tr;
      case "completed":
        return 'Completed'.tr;
      case "upcoming":
        return 'Upcoming'.tr;
      case "active":
        return 'Active'.tr;
      case "postponed":
        return 'Postponed'.tr;
      default:
        return 'Unknown'.tr;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "open":
      case "active":
        return Colors.green;
      case "closed":
        return Colors.red;
      case "completed":
        return Colors.blue;
      case "upcoming":
        return Colors.orange;
      case "postponed":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleFactor = size.width / 375; // base width = iPhone 11
    final itemWidth = size.width * 0.75;
    final theme = Theme.of(context);

    final double progress = widget.project.targetDonation == 0
        ? 0
        : widget.project.donatedAmount / widget.project.targetDonation;
    print(progress);
    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark
          ? theme.scaffoldBackgroundColor
          : thirdColor,
      appBar: AppBar(
        backgroundColor: theme.brightness == Brightness.dark
            ? theme.scaffoldBackgroundColor
            : thirdColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Project Details'.tr,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : textBlack,
            fontWeight: FontWeight.bold,
            fontSize: 18 * scaleFactor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : textBlack,
          ),
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
              child: widget.project.coverImage != null
                  ? Image.network(
                      widget.project.coverImage!,
                      width: double.infinity,
                      height: size.height * 0.25,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/logo1.png',
                          width: double.infinity,
                          height: size.height * 0.25,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/logo1.png',
                      width: double.infinity,
                      height: size.height * 0.25,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              widget.project.name,
              style: TextStyle(
                fontSize: 20 * scaleFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              widget.project.description!,
              style: TextStyle(
                fontSize: 14 * scaleFactor,
                color: theme.brightness == Brightness.dark
                    ? Colors.white
                    : textBlack,
                height: 1.5,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: EventCardInformation(
                      icon: Icons.calendar_month,
                      title: 'Start Date'.tr,
                      value: _formatDate(widget.project.startDate),
                      fontScale: scaleFactor,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 105,
                    child: EventCardInformation(
                      icon: Icons.calendar_today,
                      title: 'End Date'.tr,
                      value: _formatDate(widget.project.endDate),
                      fontScale: scaleFactor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: _getStatusColor(widget.project.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: _getStatusColor(widget.project.status),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    "${"Status:".tr} ${_getStatusText(widget.project.status)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(widget.project.status),
                      fontSize: 14 * scaleFactor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Project Statistics".tr,
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.bold,
                color: theme.brightness == Brightness.dark
                    ? Colors.white
                    : textBlack,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Container(
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildStatRow(
                    "Target Donation".tr,
                    "\$${widget.project.targetDonation}",
                    Icons.monetization_on,
                    context,
                  ),
                  _buildStatRow(
                    "Donated Amount".tr,
                    "\$${widget.project.donatedAmount}",
                    Icons.attach_money,
                    context,
                  ),
                  _buildStatRow(
                    "Remaining Amount".tr,
                    "\$${widget.project.remainingAmount}",
                    Icons.money_off,
                    context,
                  ),
                  _buildStatRow(
                    "Total Donations".tr,
                    widget.project.totalDonations.toString(),
                    Icons.payments,
                    context,
                  ),
                  _buildStatRow(
                    "Total Volunteers".tr,
                    widget.project.totalVolunteers.toString(),
                    Icons.people,
                    context,
                  ),
                  _buildStatRow(
                    "Total Events".tr,
                    widget.project.totalEvents.toString(),
                    Icons.event,
                    context,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Donation Progress".tr,
              style: TextStyle(
                fontSize: 16 * scaleFactor,
                fontWeight: FontWeight.bold,
                color: theme.brightness == Brightness.dark
                    ? Colors.white
                    : textBlack,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: progress == null ? 0 : progress,
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
                  "${'Collected:'.tr} \$${widget.project.donatedAmount}",
                  style: TextStyle(
                    color: theme.brightness == Brightness.dark
                        ? Colors.white
                        : primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14 * scaleFactor,
                  ),
                ),
                Text(
                  "${'Target:'.tr} \$${widget.project.targetDonation}",
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const DonorLoginDialog();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Donate Now".tr,
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

  Widget _buildStatRow(
    String label,
    String value,
    IconData icon,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.brightness == Brightness.dark
                ? Colors.white70
                : Colors.grey[700],
          ),
          SizedBox(width: size.width * 0.03),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: theme.brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
