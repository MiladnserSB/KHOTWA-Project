import 'package:flutter/material.dart';
import 'package:khotwa/widgets/Home_Events_Card.dart';
import 'package:khotwa/widgets/Home_Person_Card.dart';
import 'package:khotwa/widgets/Home_Projects_Card.dart';

class HomePageVisitor extends StatelessWidget {
  final TextStyle titleStyle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color(0xFFDDA15E),
    fontFamily: '._Acumin Variable Concept',
  );

  final TextStyle subtitleStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Color(0xFFDDA15E),
    fontFamily: '._Acumin Variable Concept',
  );

  final List<Map<String, String>> personList = [
    {
      "name": "Robert Fox",
      "role": "Admin",
      "image": 'assets/images/person.jpg',
    },
    {
      "name": "Theresa Webb",
      "role": "Advisor",
      "image": 'assets/images/person.jpg',
    },
    {
      "name": "Kristin Watson",
      "role": "Serinan",
      "image": 'assets/images/person.jpg',
    },
    {
      "name": "Eleanor Pena",
      "role": "Auditar",
      "image": 'assets/images/person.jpg',
    },
  ];

  final List<Map<String, String>> eventsList = [
    {'title': 'Community Cleanup', 'image': 'assets/images/image.png'},
    {'title': 'Food Drive', 'image': 'assets/images/image.png'},
  ];

  final List<Map<String, dynamic>> projectsList = [
    {
      "name": "Education Support",
      "organization": "Charity Org",
      "paid": 15000.0,
      "total": 20000.0,
    },
    {
      "name": "Refugee Assistance",
      "organization": "Relief Group",
      "paid": 8000.0,
      "total": 25000.0,
    },
    {
      "name": "Community Water Well",
      "organization": "Water Foundation",
      "paid": 40000.0,
      "total": 50000.0,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Step Volunteering Team", style: titleStyle),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                "Step Volunteering Team is dedicated to empowering communities through impactful initiatives and sustainable solutions.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: '._Acumin Variable Concept',
                ),
              ),
              const SizedBox(height: 20),
              Text("Hall of Honor", style: subtitleStyle),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: personList.length,
                  itemBuilder: (context, index) {
                    final person = personList[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: HomePersonCard(
                        name: person['name']!,
                        image: person['image']!,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(" Events and Campaigns", style: subtitleStyle),
              const SizedBox(height: 17),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventsList.length,
                  itemBuilder: (context, index) {
                    final event = eventsList[index];
                    return HomeEventsCard(
                      title: event['title']!,
                      image: event['image']!,
                      volunteersCount: 12, status: 'accept',
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text("Top Projects", style: subtitleStyle),
              const SizedBox(height: 10),
              SizedBox(
                height: 340,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: projectsList.length,
                  itemBuilder: (context, index) {
                    final project = projectsList[index];
                    return HomeProjectsCard(
                      name: project['name'],
                      organization: project['organization'],
                      paid: project['paid'],
                      total: project['total'],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
