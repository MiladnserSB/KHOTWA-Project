import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/model/profile_model.dart';
import 'package:khotwa/shared/constants/colors.dart';

class ProfilePageHeader extends StatelessWidget {
  final Profile profile;

  const ProfilePageHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScale = MediaQuery.of(context).textScaleFactor;

    String imageUrl = profile.profileImageUrl.startsWith("http")
        ? profile.profileImageUrl
        : "http://your-api-domain.com${profile.profileImageUrl}";

    return Container(
      color: theme.brightness == Brightness.dark ? Colors.black : thirdColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(imageUrl),
            onBackgroundImageError: (_, __) {
              // fallback if image fails
            },
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName,
                  style: TextStyle(
                    fontSize: 16 * textScale,
                    fontWeight: FontWeight.bold,
                    color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  style: TextStyle(
                    fontSize: 13 * textScale,
                    color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
