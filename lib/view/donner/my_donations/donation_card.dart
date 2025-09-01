import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';

class Donation {
  final String title;
  final String event;
  final String donorName;
  final String date;
  final double amount;
  final String paymentMethod;
  final String status;

  Donation({
    required this.title,
    required this.event,
    required this.donorName,
    required this.date,
    required this.amount,
    required this.paymentMethod,
    required this.status,
  });
}

class DonationCard extends StatelessWidget {
  final Donation donation;
  const DonationCard({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;
    final textScale = MediaQuery.of(context).textScaleFactor;

    IconData paymentIcon = donation.paymentMethod.contains("cash".tr) 
        ? Icons.handshake 
        : Icons.credit_card;

    Color statusColor = _getStatusColor(donation.status);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(isWide ? 20 : 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(paymentIcon, size: isWide ? 50 : 40, color: primaryColor),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donation.title,
                        style: TextStyle(
                          fontSize: isWide ? 18 * textScale : 16 * textScale,
                          fontWeight: FontWeight.bold,
                          color: textBlack,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        donation.event,
                        style: TextStyle(
                          fontSize: isWide ? 15 * textScale : 13 * textScale,
                          color: grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                Text(
                  "\$${donation.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: isWide ? 18 * textScale : 16 * textScale,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: grey),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          donation.donorName,
                          style: TextStyle(
                              fontSize: 13 * textScale, color: grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.calendar_today,
                          size: 16, color: grey),
                      const SizedBox(width: 4),
                      Text(
                        donation.date,
                        style:
                            TextStyle(fontSize: 13 * textScale, color: grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    donation.status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}