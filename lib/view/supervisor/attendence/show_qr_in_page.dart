import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQrInPage extends StatelessWidget {
  const ShowQrInPage({super.key});

  final String dummyToken = "DUMMY-TOKEN-1234567890";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          'Check in QR',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                'Scan this QR Checking in',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textBlack,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
          
              // QR Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: QrImageView(
                    data: dummyToken,
                    version: QrVersions.auto,
                    size: size.width * 0.6,
                    gapless: false,
                    // eyeStyle: QrEyeStyle(
                    //   color: secondaryColor,
                    //   eyeShape: QrEyeShape.square,
                    // ),
                    dataModuleStyle: QrDataModuleStyle(
                      color: Colors.black,
                      dataModuleShape: QrDataModuleShape.square,
                    ),
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
