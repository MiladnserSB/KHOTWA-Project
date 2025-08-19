import 'package:flutter/material.dart';

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
    return 
       Column(
        children: [
          CircleAvatar(
            radius: 40,
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
       );
    
  }
}
