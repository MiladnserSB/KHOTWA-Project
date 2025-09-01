import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/project_details/project_details_page.dart';

class HomeProjectsCard extends StatelessWidget {
  final String name;
  final String organization;
  final double paid;
  final double total;

  const HomeProjectsCard({
    super.key,
    required this.name,
    required this.organization,
    required this.paid,
    required this.total,
  });

  String formatNumber(double number) {
    String langCode = Get.locale?.languageCode ?? 'en';
    if (langCode == 'ar') {
      const arabicNumbers = ['٠','١','٢','٣','٤','٥','٦','٧','٨','٩'];
      return number.toStringAsFixed(0).split('').map((e) {
        if (RegExp(r'\d').hasMatch(e)) {
          return arabicNumbers[int.parse(e)];
        } else {
          return e;
        }
      }).join('');
    } else {
      // Format with commas for thousands
      return number.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    double progress = total > 0 ? paid / total : 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? thirdColor : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))],
      ),
      width: 235,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/projets.jpg',
              height: 120,
              width: 250,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold,
              color: theme.brightness == Brightness.dark ? Colors.white : Colors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            organization,
            style: TextStyle(
              fontSize: 12, 
              color: theme.brightness == Brightness.dark ? Colors.grey[300] : Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.grey[300],
            minHeight: 8,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
              Text(
                'paid'.trParams({'amount'.tr: formatNumber(paid)}),
                style: const TextStyle(fontSize: 11, color: Colors.green),
              ),
              Text(
                'remaining'.trParams({'amount'.tr: formatNumber(total - paid)}),
                style: const TextStyle(fontSize: 11, color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectDetailsPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDDA15E),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Text(
              'Details'.tr,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}