import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/donner_controller.dart';
import 'package:khotwa/model/my_donations_model.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/donner/my_donations/donation_card.dart';

class MyDonationsPage extends StatefulWidget {
  const MyDonationsPage({super.key});

  @override
  State<MyDonationsPage> createState() => _MyDonationsPageState();
}

class _MyDonationsPageState extends State<MyDonationsPage> {
  final DonorController controller = Get.find<DonorController>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await controller.fetchMyDonations();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          theme.brightness == Brightness.dark ? Colors.black : thirdColor,
      appBar: AppBar(
        backgroundColor:
            theme.brightness == Brightness.dark ? primaryColor : secondaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Donations".tr,
          style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
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
    final DonorController controller = Get.find<DonorController>();
    final width = MediaQuery.of(context).size.width;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.myDonations.isEmpty) {
        return Center(
          child: Text(
            "No donations found".tr,
            style: TextStyle(fontSize: 16, color: grey),
          ),
        );
      }

      // ✅ Mobile layout
      if (width < 600) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.myDonations.length,
          itemBuilder: (context, index) {
            return DonationCard(
              donation: _convertToDonation(controller.myDonations[index]),
            );
          },
        );
      }

      // ✅ Tablet / Desktop layout
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
            return DonationCard(
              donation: _convertToDonation(controller.myDonations[index]),
            );
          },
        ),
      );
    });
  }

  /// ✅ Convert backend model -> UI-friendly model
  Donation _convertToDonation(DonationModel model) {
    return Donation(
      title: model.project ??"-",
      event: model.event ?? "-",
      donorName: model.donorName ?? "-",
      date: _formatDate(model.donatedAt),
      amount: double.tryParse(model.amount) ?? 0,
      paymentMethod: model.method.toLowerCase(),
      status: _getStatusText(model.paymentStatus),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

  String _getStatusText(String paymentStatus) {
    switch (paymentStatus.toLowerCase()) {
      case "completed":
      case "success":
        return "Completed";
      case "pending":
        return "Pending";
      case "failed":
        return "Failed";
      default:
        return paymentStatus;
    }
  }
}
