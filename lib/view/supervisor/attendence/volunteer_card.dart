import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class VolunteerCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final bool checked;
  final bool isCheckIn;
  final ValueChanged<bool?> onCheckChanged;
  final VoidCallback onFeedbackPressed;

  const VolunteerCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.checked,
    required this.onCheckChanged,
    required this.onFeedbackPressed,
    required this.isCheckIn,
  });

  @override
  Widget build(BuildContext context) {
    final double fontScale = MediaQuery.of(context).size.width / 375;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14 * fontScale,
            color: textBlack,
          ),
        ),
        subtitle: Text(
          role,
          style: TextStyle(fontSize: 13 * fontScale, color: grey),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: checked,
              onChanged: onCheckChanged,
              activeColor: primaryColor,
            ),
           isCheckIn? OutlinedButton(
              onPressed: onFeedbackPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: secondaryColor,
                side: BorderSide(color: secondaryColor, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Feedback",
                style: TextStyle(
                  fontSize: 12 * fontScale,
                  fontWeight: FontWeight.w600,
                  color: white,
                ),
              ),
            ): SizedBox(width: 0.1,),
          ],
        ),
      ),
    );
  }
}
