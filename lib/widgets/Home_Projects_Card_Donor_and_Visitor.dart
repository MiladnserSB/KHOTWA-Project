import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Details_Page.dart';

class HomeProjectsCardDonorAndVisitor extends StatelessWidget {
  final String name;
  final String organization;
  final double paid;
  final double total;

  const HomeProjectsCardDonorAndVisitor({
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
                'Paid: ${paid.toStringAsFixed(0)}',
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 16,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.lock_outline, size: 48, color: Colors.orange[800]),
                              SizedBox(height: 15),
                              Text(
                                "Login Required",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: '._Acumin Variable Concept',
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Please log in to continue with the donation process.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontFamily: '._Acumin Variable Concept',
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                   style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFDDA15E),
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text("Cancel",style: TextStyle(color: primaryColor),),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFDDA15E),
                                      foregroundColor: primaryColor,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontFamily: '._Acumin Variable Concept',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDDA15E),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Donate',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: '._Acumin Variable Concept',
                    color: primaryColor,
                  ),
                ),
              ),
              SizedBox(width: 5),
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
                  'Details',
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
