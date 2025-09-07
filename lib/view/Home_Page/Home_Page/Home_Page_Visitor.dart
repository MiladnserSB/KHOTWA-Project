import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/Search_controller.dart';
import 'package:khotwa/controller/visitor_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Cards/Home_Events_Card.dart';
import 'package:khotwa/view/Home_Page/Cards/Home_Person_Card.dart';
import 'package:khotwa/view/Home_Page/Cards/Home_Projects_Card_Donor_and_Visitor.dart';
import 'package:khotwa/view/Search/Search_results_page.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';
import 'package:khotwa/view/notifications/notifications_list_page.dart';
import 'package:khotwa/view/profile/profile_page.dart';
import 'package:khotwa/widgets/custom_progress_indicator.dart';

class HomePageVisitor extends StatefulWidget {
  @override
  State<HomePageVisitor> createState() => _HomePageVisitorState();
}

class _HomePageVisitorState extends State<HomePageVisitor> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final VisitorController visitorController = Get.put(
    VisitorController(),
  );
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
    _loadData();
  }

  Future<void> _loadData() async {
    await visitorController.fetchTopProjects();
    await visitorController.fetchAllEvents();
    await visitorController.fetchAllProjects();
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.brightness == Brightness.dark
          ? theme.scaffoldBackgroundColor
          : thirdColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: 30,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NotificationsListPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                focusNode: _focusNode,
                 onChanged: (value) {
                  final searchController =
                      Get.isRegistered<AppSearchController>()
                      ? Get.find<AppSearchController>()
                      : Get.put(AppSearchController());

                  searchController.searchMyTasksAndAllprojectsAndAllEvents(value);
                },
                onSubmitted: (value) {
                  Get.to(() => SearchResultsPage());
                },
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

              const SizedBox(height: 20),

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

              // const SizedBox(height: 10),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "my events".tr,
              //       style: subtitleStyle.copyWith(
              //         color: theme.brightness == Brightness.dark
              //             ? Colors.white
              //             : Colors.black,
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (_) => EventsAndProjectsPage(),
              //           ),
              //         );
              //       },
              //       child: Text(
              //         "view all".tr,
              //         style: TextStyle(
              //           fontSize: 13,
              //           color: theme.brightness == Brightness.dark
              //               ? Colors.white
              //               : primaryColor,
              //           fontFamily: 'DG Heaven',
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 10),

              // SizedBox(
              //   height: 330,
              //   child: ListView.separated(
              //     controller: _myEventScrollController,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: myeventsList.length,
              //     separatorBuilder: (_, __) => const SizedBox(width: 10),
              //     itemBuilder: (context, index) {
              //       final event = myeventsList[index];
              //       double scale = _calculateScale(_myEventScroll, index, 220);
              //       return Transform.scale(
              //         scale: scale,
              //         child: HomeEventsCard(
              //           title: event['title']!,
              //           image: event['image']!,
              //           volunteersCount: 12,
              //           status: 'accept',
              //           requiredVolunteers: 1,
              //         ),
              //       );
              //     },
              //   ),
              // ),

              // const SizedBox(height: 25),

              // // Recommended Events
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Recommended".tr,
              //       style: subtitleStyle.copyWith(
              //         color: theme.brightness == Brightness.dark
              //             ? Colors.white
              //             : Colors.black,
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (_) => EventsAndProjectsPage(),
              //           ),
              //         );
              //       },
              //       child: Text(
              //         "view all".tr,
              //         style: TextStyle(
              //           fontSize: 13,
              //           color: theme.brightness == Brightness.dark
              //               ? Colors.white
              //               : primaryColor,
              //           fontFamily: 'DG Heaven',
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 10),

              // SizedBox(
              //   height: 330,
              //   child: ListView.separated(
              //     controller: _recommendedScrollController,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: myeventsList.length,
              //     separatorBuilder: (_, __) => const SizedBox(width: 10),
              //     itemBuilder: (context, index) {
              //       final event = myeventsList[index];
              //       double scale = _calculateScale(
              //         _recommendedScroll,
              //         index,
              //         240,
              //       );
              //       return Transform.scale(
              //         scale: scale,
              //         child: HomeEventsCard(
              //           title: event['title']!,
              //           image: event['image']!,
              //           volunteersCount: 12,
              //           status: 'accept',
              //           requiredVolunteers: 1,
              //         ),
              //       );
              //     },
              //   ),
              // ),

              const SizedBox(height: 25),

              // Top Projects
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "top projects".tr,
                    style: subtitleStyle.copyWith(
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => EventsAndProjectsPage(),
                      //   ),
                      // );
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

             Obx(() {
  if (visitorController.topProjects.isEmpty) {
    return const Center(
      child: CustomProgressIndicator(),
    );
  }

  return SizedBox(
    height: 370,
    child: ListView.separated(
      controller: _projectScrollController,
      scrollDirection: Axis.horizontal,
      itemCount: visitorController.topProjects.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        final project = visitorController.topProjects[index];
        double scale = _calculateScale(_projectScroll, index, 260);

        return Transform.scale(
          scale: scale,
          child: HomeProjectsCardDonorAndVisitor(
            name: project.name,
            organization: project.organization,
            paid: project.paid.toDouble(),
            total: project.activityScore
                .toDouble(), // 🔹 use real total if available in API
          ),
        );
      },
    ),
  );
}),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
