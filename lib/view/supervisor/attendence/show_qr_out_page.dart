import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';

class ShowQrOutPage extends StatelessWidget {
  const ShowQrOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final qrBytes = Get.arguments as Uint8List; // receive bytes from controller
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          "Check out QR".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.06, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Scan this QR Checking out".tr,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textBlack,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.memory(
                    qrBytes,
                    width: size.width * 0.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
