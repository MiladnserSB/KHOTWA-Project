import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/app_strings.dart';
import 'package:khotwa/widgets/auth_custom_button.dart';

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
              AppStrings.termsAndConditions,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text("1. Example term 1", style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 10),
            const Text("2. Example term 2", style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 10),
            const Text("3. Example term 3", style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 10),
            const Text("4. Example term 4", style: TextStyle(fontSize: 16, color: Colors.black54)),
            const SizedBox(height: 20),
            AuthCustomButton(title: AppStrings.close, onPressed: (){Navigator.of(context).pop();}),
          ],
        ),
      ),
    );
  }
}
