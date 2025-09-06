import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/model/profile_model.dart';
import 'package:khotwa/shared/constants/base_url.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/supervisor/create_task/create_task_page.dart';

class VolunteerCard extends StatelessWidget {
  final Profile volunteer;

  const VolunteerCard({super.key, required this.volunteer});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < 300;
        final bool isVeryCompact = constraints.maxWidth < 200;

        double avatarRadius = isVeryCompact ? 20 : (isCompact ? 24 : 30);
        double fontSize = isVeryCompact ? 12 : (isCompact ? 14 : 16);
        double subFontSize = isVeryCompact ? 10 : (isCompact ? 11 : 12);

        if (isVeryCompact) {
          return _buildCompactColumnCard(avatarRadius, fontSize, subFontSize);
        }

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(isCompact ? 8 : 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: grey.withOpacity(0.1),
                  backgroundImage: (_resolveImageUrl(volunteer.profileImageUrl)
                          .isNotEmpty)
                      ? NetworkImage(_resolveImageUrl(volunteer.profileImageUrl))
                      : const AssetImage('assets/images/default_avatar.png')
                          as ImageProvider,
                ),
                SizedBox(width: isCompact ? 8 : 12),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        volunteer.fullName ?? "-",
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: textBlack,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isCompact ? 4 : 6),
                      _buildInfoRow(Icons.location_on,
                          volunteer.city ?? "Unknown", subFontSize, isCompact),
                      SizedBox(height: isCompact ? 2 : 4),
                      _buildInfoRow(
                        Icons.access_time,
                        "${volunteer.preferredTime ?? "N/A"} • ${(volunteer.availabilityDays ?? []).join(", ")}",
                        subFontSize,
                        isCompact,
                        maxLines: 2,
                      ),
                      SizedBox(height: isCompact ? 2 : 4),
                      _buildInfoRow(
                        Icons.volunteer_activism,
                        "Total Hours: ${volunteer.totalVolunteerHours ?? 0}",
                        subFontSize,
                        isCompact,
                        color: primaryColor,
                        isBold: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isCompact ? 4 : 8),
                _buildAssignButton(isCompact, isVeryCompact),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text, double fontSize,
      bool isCompact,
      {int maxLines = 1, Color color = grey, bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: isCompact ? 12 : 14, color: color),
        SizedBox(width: isCompact ? 2 : 4),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAssignButton(bool isCompact, bool isVeryCompact) {
    return SizedBox(
      width: isVeryCompact ? 60 : (isCompact ? 70 : 80),
      child: ElevatedButton(
        onPressed: () {
          if (volunteer.id != null) {
            Get.to(() => CreateTaskPage(volunteerId: volunteer.id!));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 8 : 12,
            vertical: isCompact ? 6 : 10,
          ),
        ),
        child: FittedBox(
          child: Text("Assign",
              style: TextStyle(fontSize: isCompact ? 12 : 14)),
        ),
      ),
    );
  }

  Widget _buildCompactColumnCard(
      double avatarRadius, double fontSize, double subFontSize) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundColor: grey.withOpacity(0.1),
              backgroundImage: (_resolveImageUrl(volunteer.profileImageUrl)
                      .isNotEmpty)
                  ? NetworkImage(_resolveImageUrl(volunteer.profileImageUrl))
                  : const AssetImage('assets/images/default_avatar.png')
                      as ImageProvider,
            ),
            const SizedBox(height: 8),
            Text(volunteer.fullName ?? "-",
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: textBlack),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(volunteer.city ?? "Unknown",
                style: TextStyle(fontSize: subFontSize, color: grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (volunteer.id != null) {
                    Get.to(() => CreateTaskPage(volunteerId: volunteer.id!));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: Text("Assign",
                    style: TextStyle(fontSize: subFontSize),
                    overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String _resolveImageUrl(String? path) {
  if (path == null || path.isEmpty) return '';
  if (path.startsWith('http')) return path;
  if (baseUrl.endsWith('/') && path.startsWith('/')) {
    return baseUrl + path.substring(1);
  }
  return baseUrl + path;
}
