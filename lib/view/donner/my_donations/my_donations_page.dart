import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/donner/my_donations/donation_card.dart';


class MyDonationsPage extends StatelessWidget {
  const MyDonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textBlack),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Donations",
          style: TextStyle(
            color: textBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const ResponsiveDonationsList(),
    );
  }
}

class ResponsiveDonationsList extends StatelessWidget {
  const ResponsiveDonationsList({super.key});

  // Mock data (replace with GetX API later)
  List<Donation> _mockDonations() {
    return [
      Donation(
        title: "Save the Amazon",
        event: "MetGalaEvent",
        donorName: "Alaa Alazba",
        date: "22-8-2025",
        amount: 50.0,
        paymentMethod: "cash",
        status: "Completed",
      ),
      Donation(
        title: "Help Gaza Children",
        event: "Charity Marathon",
        donorName: "John Doe",
        date: "15-7-2025",
        amount: 120.0,
        paymentMethod: "card",
        status: "Completed",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final donations = _mockDonations();
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: donations.length,
        itemBuilder: (context, index) {
          return DonationCard(donation: donations[index]);
        },
      );
    } else {
      final crossAxisCount = width > 1024 ? 3 : 2; // desktop → 3, tablet → 2
      return Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          itemCount: donations.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.6, // card shape
          ),
          itemBuilder: (context, index) {
            return DonationCard(donation: donations[index]);
          },
        ),
      );
    }
  }
}

