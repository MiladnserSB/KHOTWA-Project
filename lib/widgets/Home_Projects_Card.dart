import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Details_Page.dart';

class HomeProjectsCard extends StatelessWidget {
  final String name;
  final String organization;
  final double paid;
  final double total;

  const HomeProjectsCard({
    super.key,
    required this.name,
    required this.organization,
    required this.paid,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    double progress = total > 0 ? paid / total : 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      width: 235,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/projets.jpg',
              height: 120,
              width: 250,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: '._Acumin Variable Concept',
            ),
          ),
          SizedBox(height: 6),
          Text(
            organization,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[700],
              fontFamily: '._Acumin Variable Concept',
            ),
          ),
          SizedBox(height: 15),
          LinearProgressIndicator(
            value: progress,
            color: Colors.green,
            backgroundColor: Colors.grey[300],
            minHeight: 8,
            borderRadius: BorderRadius.circular(6),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'paid: ${paid.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.green[800],
                  fontFamily: '._Acumin Variable Concept',
                ),
              ),
              Text(
                'Remaining: ${(total - paid).toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.red[800],
                  fontFamily: '._Acumin Variable Concept',
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              SizedBox(width: 5,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsPage(
                        title: name,
                        image: 'assets/images/projets.jpg',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDDA15E),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: '._Acumin Variable Concept',
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
