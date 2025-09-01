
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:khotwa/shared/constants/colors.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.size,
    required this.imagePath,
    required this.projectName,
    required this.progressPercentage, // 0.0 to 1.0
  });

  final Size size;
  final String imagePath;
  final String projectName;
  final double progressPercentage;

  @override
  Widget build(BuildContext context) {
                      final theme = Theme.of(context); 

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with overlay
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    20.0,
                  ), // Set your desired border radius
                  child: Image.asset(
                    imagePath,
                    height: size.height * 0.22,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                   
                      borderRadius: BorderRadius.circular(
                        21.0,
                      ), // Set your desired border radius

                  
                    ),
                  ),
                ),
              ],
            ),

            // Project name
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
              child: Text(
                projectName,
                style: TextStyle(
                  fontSize: size.width * 0.048,
                  fontWeight: FontWeight.w700,
                   color:   theme.brightness == Brightness.dark
            ? Colors.white
            : textBlack,
                  fontFamily: 'Acumin',
                ),
              ),
            ),

            // Progress bar & percentage
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label
              
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: progressPercentage,
                      minHeight: 10,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 22, 70, 26),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
'${(progressPercentage * 100).toInt()}% ${'funded'.tr}',

                    style: TextStyle(
                      fontSize: size.width * 0.038,
                      fontWeight: FontWeight.w600,
                      color:   theme.brightness == Brightness.dark
            ? Colors.white
            : textBlack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
