import 'package:flutter/material.dart';
import 'package:khotwa/widgets/Animated_Bottom_Bar_Visitor.dart';

class HomePageVoulunteer extends StatelessWidget {
  final TextStyle titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Color(0xFFDDA15E),                          fontFamily: '._Acumin Variable Concept',
);
  final TextStyle subtitleStyle = TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xFFDDA15E),                          fontFamily: '._Acumin Variable Concept',
);

  final List<Map<String, String>> honorList = [
    {"name": "Robert Fox", "role": "Admin", "image": 'assets/images/person.jpg'},
    {"name": "Theresa Webb", "role": "Advisor", "image": 'assets/images/person.jpg'},
    {"name": "Kristin Watson", "role": "Serinan", "image": 'assets/images/person.jpg'},
    {"name": "Eleanor Pena", "role": "Auditar", "image": 'assets/images/person.jpg'},
  ];

  final List<String> eventsList = [
    "End Hunger Campaign",
    "Health Awareness Seminar",
    "Go Away","Welcom vvv"
    // Add more events as needed
  ];

  final List<Map<String, dynamic>> projectsList = [
    {
      "name": "Education Support",
      "organization": "Charity Org",
      "paid": 15000.0,
      "total": 20000.0
    },
    {
      "name": "Refugee Assistance",
      "organization": "Relief Group",
      "paid": 8000.0,
      "total": 25000.0
    },
    {
      "name": "Community Water Well",
      "organization": "Water Foundation",
      "paid": 40000.0,
      "total": 50000.0
    },
  ];

  Widget buildPerson(Map<String, String> person) {
    return Column(
      children: [
        CircleAvatar(radius: 36, backgroundImage: AssetImage(person['image']!)),
        SizedBox(height: 2),
        Text(person['name']!, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,                          fontFamily: '._Acumin Variable Concept',
)),
        Text(person['role']!, style: TextStyle(color: Colors.grey,fontSize: 13,                          fontFamily: '._Acumin Variable Concept',
)),
      ],
    );
  }

  Widget buildCard(String title, String bgImage, {bool isEvent = false, double? raised, double? goal}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 110,
      width: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              bgImage,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                      fontFamily: '._Acumin Variable Concept',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black45, blurRadius: 4)],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget buildProjectCard(String name, String organization, double paid, double total) {
  double progress = total > 0 ? paid / total : 0;

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    width: 260,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/projets.jpg', 
            height: 120,
            width: 300,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10),

        Text(
          name,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,  fontFamily: '._Acumin Variable Concept',),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6),

        Text(
          organization,
          style: TextStyle(fontSize: 12, color: Colors.grey[700],  fontFamily: '._Acumin Variable Concept',),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),

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
              style: TextStyle(fontSize: 13, color: Colors.green[800],  fontFamily: '._Acumin Variable Concept',),
            ),
            Text(
              'Remaining: ${(total - paid).toStringAsFixed(0)}',
              style: TextStyle(fontSize: 13, color: Colors.red[800],  fontFamily: '._Acumin Variable Concept',),
            ),
          ],
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Step Volunteering Team", style: titleStyle),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search))
                ],
              ),
              SizedBox(height: 6),
              Text("Step Volunteering Team is dedicated to empowering communities through impactful initiatives and sustainable solutions.", style: TextStyle(fontSize: 16,  fontFamily: '._Acumin Variable Concept',)),
              SizedBox(height: 20),
              Text("Hall of Honor", style: titleStyle),
              SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: honorList.length,
                  separatorBuilder: (_, __) => SizedBox(width: 20),
                  itemBuilder: (context, index) => buildPerson(honorList[index]),
                ),
              ),
              SizedBox(height: 20),
              Text("Recommended Events and Campaigns", style: subtitleStyle),
              SizedBox(height: 17),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: eventsList.map((title) =>
                    buildCard(title, 'assets/images/image.png', isEvent: true)
                  ).toList(),
                ),
              ),
              SizedBox(height: 20),
              Text("Top Projects", style: titleStyle),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: projectsList.map((project) =>
                    buildProjectCard(
                      project["name"],
                      project["organization"],
                      project["paid"],
                      project["total"],
                    )
                  ).toList(),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}