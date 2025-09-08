import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/Search_controller.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Cards/Home_Events_Card.dart';
import 'package:khotwa/view/Home_Page/Cards/Home_Person_Card.dart';
import 'package:khotwa/view/Home_Page/Cards/Home_Projects_Card.dart';
import 'package:khotwa/view/Search/Search_results_page.dart';
import 'package:khotwa/view/event_and_projects/event_details/event_details_page.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';
import 'package:khotwa/view/notifications/notifications_list_page.dart';
import 'package:khotwa/view/profile/profile_page.dart';
import 'package:khotwa/widgets/custom_progress_indicator.dart';

class HomePageVolunteer extends StatefulWidget {
  const HomePageVolunteer({super.key});

  @override
  State<HomePageVolunteer> createState() => _HomePageVolunteerState();
}

class _HomePageVolunteerState extends State<HomePageVolunteer> {
  bool isLoading1 = false;
  bool isLoading2 = false;
  bool isLoading3 = false;

  Future<void> _onViewAllPressed(int index) async {
    setState(() {
      if (index == 1) isLoading1 = true;
      if (index == 2) isLoading2 = true;
      if (index == 3) isLoading3 = true;
    });

    await Future.delayed(const Duration(seconds: 120));

    setState(() {
      if (index == 1) isLoading1 = false;
      if (index == 2) isLoading2 = false;
      if (index == 3) isLoading3 = false;
    });
  }

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final VolunteerController _volunteerController = Get.put(
    VolunteerController(),
  );

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
    {"name": "Jeeny", "role": "Admin", "image": 'assets/images/jeeny.jpg'},
    {"name": "Milad", "role": "Advisor", "image": 'assets/images/Milad.jpg'},
    {
      "name": "Abood",
      "role": "Serinan",
      "image": 'assets/images/photo_2025-09-07_23-25-37.jpg',
    },
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

    _loadData();
  }

  Future<void> _loadData() async {
    await _volunteerController.fetchTopProjects();
    if (_volunteerController.topProjects.isNotEmpty) {
      await _volunteerController.fetchRecommendedEvents();
    }
    await _volunteerController.fetchMyEvents();
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          child: Column(
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
                        'assets/images/image.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        "assets/images/logo2.png",
                        width: 100,
                        height: 80,
                        fit: BoxFit.contain,
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

                  searchController.searchMyTasksAndAllprojectsAndAllEvents(
                    value,
                  );
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
                    vertical: 10,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
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

              const SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "top ".tr,
                        style: subtitleStyle.copyWith(color: primaryColor),
                      ),
                      TextSpan(
                        text: "Volunteers".tr,
                        style: subtitleStyle.copyWith(color: secondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 165,
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

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "top projects".tr,
                    style: subtitleStyle.copyWith(color: secondaryColor),
                  ),
                  GestureDetector(
                    onTap: () => _onViewAllPressed(3),
                    child: isLoading3
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            "view all".tr,
                            style: TextStyle(
                              fontSize: 10,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: 'DG Heaven',
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Obx(() {
                if (_volunteerController.isLoading.value &&
                    _volunteerController.topProjects.isEmpty) {
                  return SizedBox(
                    height: 350,
                    child: Center(child: CustomProgressIndicator()),
                  );
                }

                if (_volunteerController.topProjects.isEmpty) {
                  return SizedBox(
                    height: 350,
                    child: Center(child: CustomProgressIndicator()),
                  );
                }

                return SizedBox(
                  height: 370,
                  child: ListView.separated(
                    controller: _projectScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _volunteerController.topProjects.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final project = _volunteerController.topProjects[index];
                      double scale = _calculateScale(
                        _projectScroll,
                        index,
                        260,
                      );

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

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommended Events".tr,
                    style: subtitleStyle.copyWith(color: secondaryColor),
                  ),
                  GestureDetector(
                    onTap: () => _onViewAllPressed(2),
                    child: isLoading2
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            "view all".tr,
                            style: TextStyle(
                              fontSize: 10,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: 'DG Heaven',
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              Obx(() {
                if (_volunteerController.isLoading.value &&
                    _volunteerController.recommendedEvents.isEmpty) {
                  return SizedBox(
                    height: 330,
                    child: CustomProgressIndicator(),
                  );
                }

                if (_volunteerController.recommendedEvents.isEmpty) {
                  return SizedBox(
                    height: 330,
                    child: Center(child: CustomProgressIndicator()),
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
                      final event =
                          _volunteerController.recommendedEvents[index];
                      double scale = _calculateScale(
                        _recommendedScroll,
                        index,
                        240,
                      );
                      return Transform.scale(
                        scale: scale,
                        child: GestureDetector(
                          onTap: () {
                            // Get.to(EventDetailsPage(event: null,));
                          },
                          child: HomeEventsCard(
                            title: event.title ?? "No title",
                            image: event.coverImage ?? 'assets/images/new.jpg',
                            volunteersCount: event.currentVolunteers ?? 0,
                            status: event.status ?? '-',
                            requiredVolunteers: event.requiredVolunteers ?? 0,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "my events".tr,
                    style: subtitleStyle.copyWith(color: secondaryColor),
                  ),
                  GestureDetector(
                    onTap: () => _onViewAllPressed(1),
                    child: isLoading1
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            "view all".tr,
                            style: TextStyle(
                              fontSize: 10,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: 'DG Heaven',
                            ),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Obx(() {
                if (_volunteerController.isLoading.value) {
                  return SizedBox(
                    height: 300,
                    child: Center(child: CustomProgressIndicator()),
                  );
                }

                if (_volunteerController.myEvents.isEmpty) {
                  return SizedBox(
                    height: 330,
                    child: Center(child: Text("No events found")),
                  );
                }

                return SizedBox(
                  height: 330,
                  child: ListView.separated(
                    controller: _myEventScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: _volunteerController.myEvents.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final event = _volunteerController.myEvents[index];
                      double scale = _calculateScale(
                        _myEventScroll,
                        index,
                        220,
                      );

                      return Transform.scale(
                        scale: scale,
                        child: HomeEventsCard(
                          title: event.title,
                          image: event.coverImage ?? 'assets/images/new.jpg',
                          volunteersCount: event.currentVolunteers,
                          requiredVolunteers: event.requiredVolunteers,
                          status: event.status.toString().split('.').last,
                        ),
                      );
                    },
                  ),
                );
              }),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
