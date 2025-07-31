import 'package:flutter/material.dart';
import 'package:khotwa/view/Home_Page/Details_Page.dart';

class HomePersonCard extends StatelessWidget {
  final String name;
  final String image;

  const HomePersonCard({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsPage(
              title: name,
              image: image,
            ),
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(height: 2),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontFamily: '._Acumin Variable Concept',
            ),
          ),
        
        ],
      ),
    );
  }
}
