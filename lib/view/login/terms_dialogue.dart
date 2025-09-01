import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';
import 'package:khotwa/shared/constants/colors.dart';

class TermsDialog extends StatelessWidget {
  const TermsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: 300.0,
        child: ListView(
          children: [
            Text(
              "termsAndConditions".tr,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text("1. Example term 1".tr, style: TextStyle(fontSize: 16, color: Colors.white)),
SizedBox(height: 10),
Text("2. Example term 2".tr, style: TextStyle(fontSize: 16, color: Colors.white)),
SizedBox(height: 10),
Text("3. Example term 3".tr, style: TextStyle(fontSize: 16, color: Colors.white)),
SizedBox(height: 10),
Text("4. Example term 4".tr, style: TextStyle(fontSize: 16, color: Colors.white)),

            const SizedBox(height: 20),
            AuthCustomButton(title:"close".tr, onPressed: (){Navigator.of(context).pop();}),
          ],
        ),
      ),
    );
  }
}
