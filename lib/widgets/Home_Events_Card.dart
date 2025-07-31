import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Details_Page.dart';

class HomeEventsCard extends StatelessWidget {
  final String title;
  final String image;
  final int volunteersCount;
  final String status;

  const HomeEventsCard({
    super.key,
    required this.title,
    required this.image,
    required this.volunteersCount,
    required this.status,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return Colors.amber;
      case 'active':
        return Colors.green;
      case 'completed':
        return Colors.black;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      width:  220,   
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.asset(
                  image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.group, size: 18, color: primaryColor),
                const SizedBox(width: 6),
                Text(
                  "$volunteersCount/100 volunteer",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:Color(0xFFDDA15E) ,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsPage(title: title, image: image),
                ),
              );
            },
            child: const Text('View Details',style:TextStyle(color:  primaryColor)),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
