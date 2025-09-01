import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/donner_controller.dart';
import 'package:khotwa/model/my_donations_model.dart';
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
        title:  Text(
          "My Donations".tr,
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

  @override
  Widget build(BuildContext context) {
    final DonorController controller = Get.put(DonorController());
    final width = MediaQuery.of(context).size.width;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.myDonations.isEmpty) {
        return  Center(
          child: Text(
            "No donations found".tr,
            style: TextStyle(fontSize: 16, color: grey),
          ),
        );
      }

      if (width < 600) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.myDonations.length,
          itemBuilder: (context, index) {
            return DonationCard(donation: _convertToDonation(controller.myDonations[index]));
          },
        );
      } else {
        final crossAxisCount = width > 1024 ? 3 : 2;
        return Padding(
          padding: const EdgeInsets.all(24),
          child: GridView.builder(
            itemCount: controller.myDonations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.6,
            ),
            itemBuilder: (context, index) {
              return DonationCard(donation: _convertToDonation(controller.myDonations[index]));
            },
          ),
        );
      }
    });
  }

  // Helper method to convert DonationModel to Donation
  Donation _convertToDonation(DonationModel model) {
    return Donation(
      title: model.project,
      event: model.event,
      donorName: model.donorName,
      date: _formatDate(model.donatedAt),
      amount: double.parse(model.amount),
      paymentMethod: model.method.toLowerCase(),
      status: _getStatusText(model.paymentStatus),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

  String _getStatusText(String paymentStatus) {
    switch (paymentStatus.toLowerCase()) {
      case "Completed":
      case "success":
        return "Completed";
      case "Pending":
        return "Pending";
      case "Failed":
        return "Failed";
      default:
        return paymentStatus;
    }
  }
}