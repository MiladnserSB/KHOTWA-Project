import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/login/login_page.dart';
import 'package:khotwa/widgets/Home_Events_Card.dart';
import 'package:khotwa/widgets/Home_Person_Card.dart';
import 'package:khotwa/widgets/Home_Projects_Card_Donor_and_Visitor.dart';

class HomePageDonor extends StatefulWidget {
  @override
  State<HomePageDonor> createState() => _HomePageDonorState();
}

class _HomePageDonorState extends State<HomePageDonor> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  final ScrollController _myEventScrollController = ScrollController();
  final ScrollController _recommendedScrollController = ScrollController();
  final ScrollController _projectScrollController = ScrollController();

  double _myEventScroll = 0.0;
  double _recommendedScroll = 0.0;
  double _projectScroll = 0.0;

  @override
  void initState() {
    super.initState();

    _myEventScrollController.addListener(() {
      setState(() {
        _myEventScroll = _myEventScrollController.offset;
      });
    });

    _recommendedScrollController.addListener(() {
      setState(() {
        _recommendedScroll = _recommendedScrollController.offset;
      });
    });

    _projectScrollController.addListener(() {
      setState(() {
        _projectScroll = _projectScrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _myEventScrollController.dispose();
    _recommendedScrollController.dispose();
    _projectScrollController.dispose();
    super.dispose();
  }

  bool _isPressed = false;

  final TextStyle subtitleStyle = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: primaryColor,
    fontFamily: '._Acumin Variable Concept',
    decoration: TextDecoration.underline,
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
  ];

  final List<Map<String, String>> myeventsList = [
    {'title': 'Communityworld ', 'image': 'assets/images/new.jpg'},
    {'title': 'Food Driveworld', 'image': 'assets/images/new.jpg'},
    {'title': 'Communityworld ', 'image': 'assets/images/new.jpg'},
    {'title': 'Food Driveworld', 'image': 'assets/images/new.jpg'},
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

  double _calculateScale(double scrollOffset, int index, double itemWidth) {
    double itemOffset = index * (itemWidth + 20); // 20 = spacing
    double diff = (itemOffset - scrollOffset).abs();
    double scale = 1 - (diff / (itemWidth * 3));
    return scale.clamp(0.9, 1.0);
  }

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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/new.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Text(
                        'Khotwa',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'GreatVibes',
                          color: Color(0xFFDDA15E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: 28,
                      color: _isPressed ? Color(0xFFDDA15E) : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPressed = !_isPressed;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  filled: true,
                  fillColor: Colors.grey[200],
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, size: 22),
                ),
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 15),

              Text("Hall of Honor", style: subtitleStyle),
              const SizedBox(height: 20),

              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: personList.length,
                  itemBuilder: (context, index) {
                    final person = personList[index];
                    String? medalText;
                    if (index == 0) medalText = "🥇";
                    if (index == 1) medalText = "🥈";
                    if (index == 2) medalText = "🥉";

                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HomePersonCard(
                            name: person['name'] ?? '',
                            image: person['image'] ?? '',
                          ),
                          const SizedBox(height: 5),
                          if (medalText != null)
                            Text(
                              medalText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("My Events ", style: subtitleStyle),
                  Text("View all..", style: TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 280,
                child: ListView.separated(
                  controller: _myEventScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: myeventsList.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final event = myeventsList[index];
                    double scale = _calculateScale(_myEventScroll, index, 220);
                    return Transform.scale(
                      scale: scale,
                      child: HomeEventsCard(
                        title: event['title']!,
                        image: event['image']!,
                        volunteersCount: 12,
                        status: 'accept',
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recommended Events ", style: subtitleStyle),
                  Text("View all..", style: TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 280,
                child: ListView.separated(
                  controller: _recommendedScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: myeventsList.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final event = myeventsList[index];
                    double scale = _calculateScale(
                      _recommendedScroll,
                      index,
                      240,
                    );
                    return Transform.scale(
                      scale: scale,
                      child: HomeEventsCard(
                        title: event['title']!,
                        image: event['image']!,
                        volunteersCount: 12,
                        status: 'accept',
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Projects ", style: subtitleStyle),
                  Text("View all..", style: TextStyle(fontSize: 13)),
                ],
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 330,
                child: ListView.separated(
                  controller: _projectScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: projectsList.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final project = projectsList[index];
                    double scale = _calculateScale(_projectScroll, index, 260);
                    return Transform.scale(
                      scale: scale,
                      child: HomeProjectsCardDonorAndVisitor(
                        name: project['name'],
                        organization: project['organization'],
                        paid: project['paid'],
                        total: project['total'],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
