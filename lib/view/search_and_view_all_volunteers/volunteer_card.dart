import 'package:flutter/material.dart';
import 'package:khotwa/model/profile_model.dart';
import 'package:khotwa/shared/constants/colors.dart';

class VolunteerCard extends StatelessWidget {
  final Profile volunteer;

  const VolunteerCard({super.key, required this.volunteer});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: grey.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(volunteer.profileImageUrl),
                radius: 30,
                backgroundColor: grey.withOpacity(0.1),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      volunteer.fullName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textBlack,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: grey),
                        const SizedBox(width: 4),
                        Text(
                          volunteer.city ?? "Unknown",
                          style: TextStyle(fontSize: 12, color: grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: grey),
                        const SizedBox(width: 4),
                        Text(
                          "${volunteer.preferredTime} • ${volunteer.availabilityDays.join(", ")}",
                          style: TextStyle(fontSize: 12, color: grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.volunteer_activism, size: 14, color: primaryColor),
                        const SizedBox(width: 4),
                        Text(
                          "Total Hours: ${volunteer.totalVolunteerHours ?? 0}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  // Assign logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: const Text("Assign"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
