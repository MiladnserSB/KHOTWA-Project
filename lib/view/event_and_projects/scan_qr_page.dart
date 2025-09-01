import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final MobileScannerController controller = MobileScannerController();
  String? scannedData;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              controller: controller,
              onDetect: (BarcodeCapture capture) {
                for (final barcode in capture.barcodes) {
                  final String? rawValue = barcode.rawValue;
                  if (rawValue != null) {
                    log("Scanned: $rawValue");
                    setState(() => scannedData = rawValue);
                    Navigator.pop(context, rawValue);
                  }
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: scannedData != null
                  ? Text(
                      "Result: $scannedData",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text("Scan a code"),
            ),
          )
        ],
      ),
    );
  }
}   
