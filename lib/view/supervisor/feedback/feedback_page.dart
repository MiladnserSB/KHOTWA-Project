import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/supervisor/feedback/custom_text_field.dart';
import 'package:khotwa/view/supervisor/feedback/submit_button.dart';

class VolunteerFeedbackPage extends StatefulWidget {
  final bool eventCompleted;
  const VolunteerFeedbackPage({super.key, this.eventCompleted = true});

  @override
  State<VolunteerFeedbackPage> createState() => _VolunteerFeedbackPageState();
}

class _VolunteerFeedbackPageState extends State<VolunteerFeedbackPage> {
  // ⭐ Numeric ratings
  double punctuality = 0;
  double workQuality = 0;
  double teamwork = 0;
  double initiative = 0;
  double discipline = 0;

  // ✅ Boolean ratings
  bool? initiated;
  bool? mentored;
  bool? creativeContribution;
  bool? impactful;
  bool? inspirational;

  final TextEditingController notesController = TextEditingController();
  final TextEditingController warningController = TextEditingController();
  bool warningGiven = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Validator for warnings
  String? _warningValidator(String? value) {
    if (warningGiven && (value == null || value.trim().isEmpty)) {
      return 'Please provide details for the warning';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double fontScale = size.width / 375;
    final double fieldSpacing = 20 * fontScale;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primaryColor),
        title: Text(
          "Volunteer Feedback",
          style: TextStyle(
            fontSize: 20 * fontScale,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20 * fontScale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ⚠️ Warning Section
              Container(
                padding: EdgeInsets.all(16 * fontScale),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning_amber_rounded,
                            color: Colors.redAccent, size: 20 * fontScale),
                        SizedBox(width: 8 * fontScale),
                        Text(
                          "Warning",
                          style: TextStyle(
                            fontSize: 16 * fontScale,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12 * fontScale),
                    CustomTextField(
                      controller: warningController,
                      hint: "Write warnings if any...",
                      fontScale: fontScale,
                      maxLines: 3,
                      borderColor: Colors.red,
                      validator: _warningValidator,
                      hasError: warningGiven &&
                          (warningController.text.trim().isEmpty),
                    ),
                    SizedBox(height: 12 * fontScale),
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: warningGiven
                              ? grey.withOpacity(0.5)
                              : Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 12 * fontScale,
                            horizontal: 24 * fontScale,
                          ),
                          elevation: 0,
                        ),
                        icon: Icon(Icons.warning_amber_rounded,
                            size: 18 * fontScale),
                        label: Text(
                          warningGiven ? "Warning Given" : "Issue Warning",
                          style: TextStyle(
                            fontSize: 14 * fontScale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          setState(() => warningGiven = true);
                          _formKey.currentState?.validate();
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: fieldSpacing * 1.5),

              if (widget.eventCompleted) ...[
                // ⭐ Ratings Section
                Container(
                  padding: EdgeInsets.all(16 * fontScale),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: primaryColor.withOpacity(0.1), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star_border,
                              color: primaryColor, size: 20 * fontScale),
                          SizedBox(width: 8 * fontScale),
                          Text(
                            "Rate the Volunteer",
                            style: TextStyle(
                              fontSize: 16 * fontScale,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16 * fontScale),

                      _buildStarRating("Punctuality", punctuality,
                          (val) => setState(() => punctuality = val), fontScale),
                      _buildStarRating("Work Quality", workQuality,
                          (val) => setState(() => workQuality = val), fontScale),
                      _buildStarRating("Teamwork", teamwork,
                          (val) => setState(() => teamwork = val), fontScale),
                      _buildStarRating("Initiative", initiative,
                          (val) => setState(() => initiative = val), fontScale),
                      _buildStarRating("Discipline", discipline,
                          (val) => setState(() => discipline = val), fontScale),

                      SizedBox(height: 16 * fontScale),

                      _buildYesNo("Initiated", initiated,
                          (val) => setState(() => initiated = val), fontScale),
                      _buildYesNo("Mentored", mentored,
                          (val) => setState(() => mentored = val), fontScale),
                      _buildYesNo("Creative Contribution",
                          creativeContribution,
                          (val) =>
                              setState(() => creativeContribution = val),
                          fontScale),
                      _buildYesNo("Impactful", impactful,
                          (val) => setState(() => impactful = val), fontScale),
                      _buildYesNo("Inspirational", inspirational,
                          (val) => setState(() => inspirational = val),
                          fontScale),
                    ],
                  ),
                ),

                SizedBox(height: fieldSpacing),

                // 📝 Notes Section
                Container(
                  padding: EdgeInsets.all(16 * fontScale),
                  decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: secondaryColor.withOpacity(0.1), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.note_alt,
                              color: secondaryColor, size: 20 * fontScale),
                          SizedBox(width: 8 * fontScale),
                          Text(
                            "Notes",
                            style: TextStyle(
                              fontSize: 16 * fontScale,
                              fontWeight: FontWeight.bold,
                              color: secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12 * fontScale),
                      CustomTextField(
                        controller: notesController,
                        hint: "Write your notes here...",
                        fontScale: fontScale,
                        maxLines: 4,
                        borderColor: secondaryColor,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: fieldSpacing * 1.5),

                // ✅ Submit Button
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SubmitButton(
                    fontScale: fontScale,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _submitFeedback();
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _submitFeedback() {
    final feedbackData = {
      'punctuality': punctuality,
      'workQuality': workQuality,
      'teamwork': teamwork,
      'initiative': initiative,
      'discipline': discipline,
      'initiated': initiated,
      'mentored': mentored,
      'creativeContribution': creativeContribution,
      'impactful': impactful,
      'inspirational': inspirational,
      'notes': notesController.text,
      'warning': warningGiven ? warningController.text : null,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Feedback submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    print('Feedback Data: $feedbackData');
  }

  // ===== Helpers =====

  Widget _buildStarRating(String label, double value,
      ValueChanged<double> onChanged, double fontScale) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10 * fontScale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14 * fontScale,
                fontWeight: FontWeight.w600,
                color: textBlack,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: RatingBar.builder(
              initialRating: value,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 28 * fontScale,
              unratedColor: grey.withOpacity(0.3),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: secondaryColor),
              onRatingUpdate: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYesNo(String label, bool? value,
      ValueChanged<bool> onChanged, double fontScale) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10 * fontScale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14 * fontScale,
                fontWeight: FontWeight.w600,
                color: textBlack,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _circleOption("Yes", true, value, onChanged, fontScale),
                SizedBox(width: 20 * fontScale),
                _circleOption("No", false, value, onChanged, fontScale),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleOption(String text, bool option, bool? selected,
      ValueChanged<bool> onChanged, double fontScale) {
    final isSelected = selected == option;
    return GestureDetector(
      onTap: () => onChanged(option),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 12 * fontScale, vertical: 6 * fontScale),
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? secondaryColor : grey,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 18 * fontScale,
              height: 18 * fontScale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? secondaryColor : Colors.transparent,
                border: Border.all(
                    color: isSelected ? secondaryColor : grey, width: 2),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 12 * fontScale)
                  : null,
            ),
            SizedBox(width: 6 * fontScale),
            Text(
              text,
              style: TextStyle(
                fontSize: 13 * fontScale,
                color: isSelected ? secondaryColor : textBlack,
                fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
