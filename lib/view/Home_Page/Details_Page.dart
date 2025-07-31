import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String? image;

  const DetailsPage({Key? key, required this.title,this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (image != null)
              Image.asset(image!, height: 200, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 20),
           
          ],
        ),
      ),
    );
  }
}
