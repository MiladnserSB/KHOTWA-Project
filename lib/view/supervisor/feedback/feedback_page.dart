import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/supervisor/feedback/custom_text_field.dart';
import 'package:khotwa/view/supervisor/feedback/submit_button.dart';
import 'package:khotwa/view/supervisor/feedback/title_section.dart';

class VolunteerFeedbackPage extends StatefulWidget {
  const VolunteerFeedbackPage({super.key});

  @override
  State<VolunteerFeedbackPage> createState() => _VolunteerFeedbackPageState();
}

class _VolunteerFeedbackPageState extends State<VolunteerFeedbackPage> {
  double rating = 0.0;
  final TextEditingController notesController = TextEditingController();
  final TextEditingController warningController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double fontScale = size.width / 375;
    final double fieldSpacing = 16 * fontScale;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Volunteer Feedback",
          style: TextStyle(
            fontSize: 20 * fontScale,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16 * fontScale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleSection(icon: Icons.note_alt, title: "Add Notes", fontScale: fontScale),
            SizedBox(height: 8 * fontScale),
            CustomTextField(controller: notesController, hint: "Write your notes here...", fontScale: fontScale, maxLines: 4),

            SizedBox(height: fieldSpacing),

            TitleSection(icon: Icons.warning_amber_rounded, title: "Add Warning", fontScale: fontScale),
            SizedBox(height: 8 * fontScale),
            CustomTextField(controller: warningController, hint: "Write warnings if any...", fontScale: fontScale, maxLines: 4),

            SizedBox(height: fieldSpacing),

            TitleSection(icon: Icons.star_border, title: "Rate the Volunteer", fontScale: fontScale),
            SizedBox(height: 8 * fontScale),
            Center(
              child: RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 36 * fontScale,
                unratedColor: grey.withOpacity(0.3),
                itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                itemBuilder: (context, _) => const Icon(Icons.star, color: secondaryColor),
                onRatingUpdate: (value) => setState(() => rating = value),
              ),
            ),
            SizedBox(height: 8 * fontScale),
            CustomTextField(controller: feedbackController, hint: "Share your feedback...", fontScale: fontScale, maxLines: 3),

            SizedBox(height: fieldSpacing * 1.5),
            SubmitButton(fontScale: fontScale, onPressed: () {
              // Handle submit action
            }),
          ],
        ),
      ),
    );
  }
}

