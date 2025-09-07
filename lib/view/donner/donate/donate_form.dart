import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/donner_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/donner/my_donations/my_donations_page.dart';

class DonateForm extends StatefulWidget {
  const DonateForm({super.key});

  @override
  State<DonateForm> createState() => _DonateFormState();
}

class _DonateFormState extends State<DonateForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController donorNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String? paymentMethod;

  final DonorController donorController = Get.put(DonorController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget formContent = Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: thirdColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Make a Difference Today".tr,
                          style: TextStyle(color: textBlack)),
                      const SizedBox(height: 8),
                      Text(
                          "Your benevolent gift fuels positive change in communities worldwide."
                              .tr,
                          style: TextStyle(color: textBlack)),
                      const SizedBox(height: 8),
                      Text(
                          "Every contribution, big or small, creates a ripple effect of hope and transformation."
                              .tr,
                          style: TextStyle(color: textBlack)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Donor Name
                TextFormField(
                   style: TextStyle(color: textBlack),
                  controller: donorNameController,
                  validator: (val) =>
                      val == null || val.isEmpty ? "Enter your name".tr : null,
                  decoration: InputDecoration(
                    labelText: "Donor Name".tr,
                    hintText: "John Doe",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                   style: TextStyle(color: textBlack),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter your email".tr;
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(val)) {
                      return "Enter a valid email".tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email".tr,
                    hintText: "john.doe@example.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Amount
                TextFormField(
                  style: TextStyle(color: textBlack),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Enter donation amount".tr;
                    }
                    final amount = int.tryParse(val);
                    if (amount == null || amount <= 0) {
                      return "Enter valid amount".tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Donation Amount".tr,
                    hintText: "\$ 250.00",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Payment Method
                DropdownButtonFormField<String>(
                  value: paymentMethod,
                  items:  [
                    // DropdownMenuItem(value: "card", child: Text("Card".tr)),
                    DropdownMenuItem(value: "cash", child: Text("Cash".tr)),
                  ],
                  onChanged: (val) => setState(() => paymentMethod = val),
                  decoration: InputDecoration(
                    labelText: "Payment Method".tr,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: TextStyle(
                    color: textBlack
                  ),
                  validator: (val) =>
                      val == null ? "Select a payment method".tr : null,
                ),
                const SizedBox(height: 24),

                // Donate Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showConfirmationDialog(context);
                      }
                    },
                    child: Text(
                      "Donate Now".tr,
                      style: TextStyle(color: white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // My Donations
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Get.to(() => const MyDonationsPage());
                    },
                    child: Text(
                      "My Donations".tr,
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

        return constraints.maxWidth < 600
            ? Padding(padding: const EdgeInsets.all(16), child: formContent)
            : Center(
                child: SizedBox(
                  width: 500,
                  child: Card(
                    color: white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: formContent,
                    ),
                  ),
                ),
              );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Obx(() {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      size: 50, color: secondaryColor),
                  const SizedBox(height: 16),
                  Text('Donation Confirmation'.tr,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                  const SizedBox(height: 12),
                  Text(
                    'Are you sure you want to donate for the event or project?'
                        .tr,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Cancel'.tr,
                              style: const TextStyle(color: white)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();

                            final donation =
                                await donorController.createDonation({
                              "amount": int.parse(amountController.text),
                              "project_id": 1, // TODO: dynamic later
                              "event_id": 15, // TODO: dynamic later
                              "donor_name": donorNameController.text,
                              "donor_email": emailController.text,
                              "type": paymentMethod,
                            });

                            if (donation != null) {
                              await donorController.confirmDonation({
                                "donation_id": donation.data.donationId ?? 0,
                                "transaction_id": "pi_123456789",
                                "payment_status": "paid",
                                "method": paymentMethod,
                                "amount": int.parse(amountController.text),
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Donate'.tr,
                              style: const TextStyle(color: white)),
                        ),
                      ),
                    ],
                  ),
                  if (donorController.isLoadingDonations.value)
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
