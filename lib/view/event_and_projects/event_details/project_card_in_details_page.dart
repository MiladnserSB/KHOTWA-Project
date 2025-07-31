
import 'package:flutter/material.dart';

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

                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
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
                  color: Colors.black87,
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
                  Text(
                    'Support Level',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.035,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 6),
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
                    '${(progressPercentage * 100).toInt()}% funded',
                    style: TextStyle(
                      fontSize: size.width * 0.038,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
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
