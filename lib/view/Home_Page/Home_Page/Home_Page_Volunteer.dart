import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Cards/Home_Events_Card.dart';
import 'package:khotwa/view/Home_Page/Cards/Home_Person_Card.dart';
import 'package:khotwa/view/Home_Page/Cards/Home_Projects_Card.dart';
import 'package:khotwa/view/event_and_projects/event_details/event_details_page.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';
import 'package:khotwa/view/profile/profile_page.dart';

class HomePageVolunteer extends StatefulWidget {
  const HomePageVolunteer({super.key});

  @override
  State<HomePageVolunteer> createState() => _HomePageVolunteerState();
}

class _HomePageVolunteerState extends State<HomePageVolunteer> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final VolunteerController _volunteerController = Get.put(VolunteerController());

  final ScrollController _myEventScrollController = ScrollController();
  final ScrollController _recommendedScrollController = ScrollController();
  final ScrollController _projectScrollController = ScrollController();

  double _myEventScroll = 0.0;
  double _recommendedScroll = 0.0;
  double _projectScroll = 0.0;

  bool _isPressed = false;

  final TextStyle subtitleStyle = const TextStyle(
    fontSize: 24,
    fontFamily: 'DG Heaven',
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
    {'title': 'community world', 'image': 'assets/images/new.jpg'},
    {'title': 'food drive', 'image': 'assets/images/new.jpg'},
    {'title': 'community world', 'image': 'assets/images/new.jpg'},
    {'title': 'food drive', 'image': 'assets/images/new.jpg'},
  ];

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
    
    // Load data when the page initializes
    _loadData();
  }

  Future<void> _loadData() async {
    await _volunteerController.fetchTopProjects();
    // Load recommended events if we have any event ID to use as reference
    if (_volunteerController.topProjects.isNotEmpty) {
      // Use the first project's ID or any other logic to get an event ID
      await _volunteerController.fetchRecommendedEvents();
    }
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

  double _calculateScale(double scrollOffset, int index, double itemWidth) {
    double itemOffset = index * (itemWidth + 20);
    double diff = (itemOffset - scrollOffset).abs();
    double scale = 1 - (diff / (itemWidth * 3));
    return scale.clamp(0.9, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark
          ? theme.scaffoldBackgroundColor
          : thirdColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ProfilePage()),
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
                        'Khotwa'.tr,
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'DG Heaven',
                          color: theme.brightness == Brightness.dark
                              ? secondaryColor
                              : primaryColor,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: 34,
                      color: Color(0xFFDDA15E),
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

              // Search Field
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'search'.tr,
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 22,
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),

              const SizedBox(height: 15),

              Center(
                child: Container(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(personList.length, (index) {
                      final person = personList[index];
                      String? medalText;
                      if (index == 0) medalText = "🥇";
                      if (index == 1) medalText = "🥈";
                      if (index == 2) medalText = "🥉";

                      return Padding(
                        padding: const EdgeInsets.all(9),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProfilePage(),
                                  ),
                                );
                              },
                              child: HomePersonCard(
                                name: person['name'] ?? '',
                                image: person['image'] ?? '',
                              ),
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
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // My Events
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "my events".tr,
                    style: subtitleStyle.copyWith(color: textColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventsAndProjectsPage(),
                        ),
                      );
                    },
                    child: Text(
                      "view all".tr,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white
                            : primaryColor,
                        fontFamily: 'DG Heaven',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: 330,
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
                        status: 'status accept',
                        requiredVolunteers: 1,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              // Recommended Events Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommended".tr,
                    style: subtitleStyle.copyWith(color: textColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventsAndProjectsPage(),
                        ),
                      );
                    },
                    child: Text(
                      "view all".tr,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white
                            : primaryColor,
                        fontFamily: 'DG Heaven',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Recommended Events from API
              Obx(() {
                if (_volunteerController.isLoading.value && 
                    _volunteerController.recommendedEvents.isEmpty) {
                  return SizedBox(
                    height: 330,
                    child: Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  );
                }

                if (_volunteerController.recommendedEvents.isEmpty) {
                  return SizedBox(
                    height: 330,
                    child: Center(
                      child: Text(
                        'No recommended events available',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 330,
                  child: ListView.separated(
                    controller: _recommendedScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _volunteerController.recommendedEvents.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final event = _volunteerController.recommendedEvents[index];
                      double scale = _calculateScale(
                        _recommendedScroll,
                        index,
                        240,
                      );
                      return Transform.scale(
                        scale: scale,
                        child: GestureDetector(
                          onTap: (){
                            // Get.to(EventDetailsPage());
                          },
                          child: HomeEventsCard(
                            title: event.title ?? "No title",
                            image: event.coverImage ?? 'assets/images/new.jpg',
                            volunteersCount: event.currentVolunteers ?? 0,
                            status: event.status.name ?? '-',
                            requiredVolunteers: event.requiredVolunteers ?? 0,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 25),

              // Top Projects Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "top projects".tr,
                    style: subtitleStyle.copyWith(color: textColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventsAndProjectsPage(),
                        ),
                      );
                    },
                    child: Text(
                      "view all".tr,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white
                            : primaryColor,
                        fontFamily: 'DG Heaven',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Top Projects from API
              Obx(() {
                if (_volunteerController.isLoading.value && 
                    _volunteerController.topProjects.isEmpty) {
                  return SizedBox(
                    height: 350,
                    child: Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  );
                }

                if (_volunteerController.topProjects.isEmpty) {
                  return SizedBox(
                    height: 350,
                    child: Center(
                      child: Text(
                        'No projects available',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 350,
                  child: ListView.separated(
                    controller: _projectScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _volunteerController.topProjects.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final project = _volunteerController.topProjects[index];
                      double scale = _calculateScale(_projectScroll, index, 260);
                      
                      return Transform.scale(
                        scale: scale,
                        child: HomeProjectsCard(
                          name: project.name,
                          organization: project.organization,
                          paid: project.paid.toDouble(),
                          total: (project.paid + 5000).toDouble(),
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}