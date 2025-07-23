import 'package:flutter/material.dart';

class VolunteerCampaignDetailsPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const VolunteerCampaignDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['campaign'],
            style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('التقييم', data['rate'].toString()),
            _buildInfoRow('عدد الساعات', '${data['hours']} ساعة'),
            _buildInfoRow('الدور', data['role']),
            _buildInfoRow('تاريخ المشاركة', data['date']),
            const SizedBox(height: 20),
            const Text(
              'الوصف',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(data['description'] ?? 'لا يوجد وصف'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text('$label: ',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(value),
        ],
      ),
    );
  }
}
