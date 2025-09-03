import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
   backgroundColor:  thirdColor,
        centerTitle: true,
           elevation: 0,        leading: BackButton(color: Colors.black),
      ),
      backgroundColor: thirdColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "About Us".tr,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  letterSpacing: 10,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                "We are a volunteer organization dedicated to making a positive impact in our community.\n\nOur mission is to provide support and assistance to those in need, and to create opportunities for individuals to get involved and make a difference."
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite, color: primaryColor, size: 60),
                  const SizedBox(width: 20),
                  Icon(Icons.volunteer_activism, color: Colors.brown, size: 60),
                ],
              ),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
