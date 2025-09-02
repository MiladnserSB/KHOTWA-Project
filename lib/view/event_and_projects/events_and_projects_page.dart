import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/controller/volunteer_controller.dart';
import 'package:khotwa/model/events_model.dart';
import 'package:khotwa/model/projects_model.dart';
 // Import your ProjectModel
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/donate_apologize_button.dart';
import 'package:khotwa/view/event_and_projects/event_details/event_details_page.dart';
import 'package:khotwa/view/event_and_projects/project_details/project_details_page.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:intl/intl.dart';

String formatNumber(num number, String locale) {
  return NumberFormat.decimalPattern(locale).format(number);
}

class EventsAndProjectsPage extends StatefulWidget {
  const EventsAndProjectsPage({super.key});

  @override
  State<EventsAndProjectsPage> createState() => _EventsAndProjectsPageState();
}

class _EventsAndProjectsPageState extends State<EventsAndProjectsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final VolunteerController _volunteerController = Get.find<VolunteerController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Fetch all events and projects when the page initializes
    _volunteerController.fetchAllEvents();
    _volunteerController.fetchAllProjects();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final size = MediaQuery.of(context).size;
    final double itemHeight = size.height * 0.38;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:  theme.brightness == Brightness.dark ? Colors.black : thirdColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.02),
                SizedBox(height: size.height * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.search,color: Colors.black,size: 20,),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(color: Colors.black),
                                  hintText: 'search'.tr,
                                  hintStyle: TextStyle(color: Colors.black,fontSize: 15),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  width: double.infinity, 
                  height: 50,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark ? Color.fromARGB(255, 77, 75, 75) : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:Row(
                    children: [
                      Expanded(
                        child: ButtonsTabBar(
                          controller: _tabController,
                          backgroundColor: secondaryColor,
                          unselectedBackgroundColor: Colors.grey[200],
                          unselectedLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12, 
                            fontWeight: FontWeight.w600,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12, 
                          ),
                          radius: 16,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 63, 
                            vertical: 8,
                          ),
                          tabs:  [
                            Tab(text: 'Events'.tr),
                            Tab(text: 'Projects'.tr),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(height: size.height * 0.02),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Events Tab
                      Obx(() {
                        if (_volunteerController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else if (_volunteerController.allEvents.isEmpty) {
                          return Center(child: Text('No events available'.tr));
                        } else {
                          return AnimatedListView(
                            size: size,
                            itemHeight: itemHeight,
                            isEvent: true,
                            events: _volunteerController.allEvents,
                            projects: [], // Empty for events tab
                          );
                        }
                      }),
                      // Projects Tab
                      Obx(() {
                        if (_volunteerController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else if (_volunteerController.allProjects.isEmpty) {
                          return Center(child: Text('No projects available'.tr));
                        } else {
                          return AnimatedListView(
                            size: size,
                            itemHeight: itemHeight,
                            isEvent: false,
                            events: [], // Empty for projects tab
                            projects: _volunteerController.allProjects,
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedListView extends StatefulWidget {
  const AnimatedListView({
    super.key,
    required this.size,
    required this.itemHeight,
    required this.isEvent,
    required this.events,
    required this.projects,
  });

  final Size size;
  final double itemHeight;
  final bool isEvent;
  final List<EventModel> events;
  final List<ProjectModel> projects;

  @override
  State<AnimatedListView> createState() => _AnimatedListViewState();
}

class _AnimatedListViewState extends State<AnimatedListView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _controller = ScrollController();
  double scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          scrollOffset = _controller.offset;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _calculateScale(int index) {
    double itemOffset = index * (widget.itemHeight + 20);
    double diff = (itemOffset - scrollOffset).abs();
    double scale = 1 - (diff / (widget.itemHeight * 4));
    return scale.clamp(0.9, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    // Determine which list to use based on isEvent flag
    final itemCount = widget.isEvent ? widget.events.length : widget.projects.length;
    
    return ListView.separated(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        double scale = _calculateScale(index);
        
        if (widget.isEvent) {
          final event = widget.events[index];
          return Transform.scale(
            scale: scale,
            child: GestureDetector(
              onTap: () {
                Get.to(() => EventDetailsPage(event: event));
              },
              child: EventCard(
                size: widget.size,
                elevation: scale > 0.98 ? 10 : 2,
                event: event,
              ),
            ),
          );
        } else {
          final project = widget.projects[index];
          return Transform.scale(
            scale: scale,
            child: GestureDetector(
              onTap: () {
                // Get.to(() => ProjectDetailsPage(project: project));
              },
              child: ProjectCard(
                size: widget.size,
                elevation: scale > 0.98 ? 10 : 2,
                project: project,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class EventCard extends StatelessWidget {
  const EventCard({
    super.key, 
    required this.size, 
    this.elevation = 2, 
    required this.event
  });

  final Size size;
  final double elevation;
  final EventModel event;

  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'open':
        return 'Open'.tr;
      case 'closed':
        return 'Closed'.tr;
      case 'completed':
        return 'Completed'.tr;
      case 'upcoming':
        return 'Upcoming'.tr;
      default:
        return 'Unknown'.tr;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
     case 'open':
        return Colors.green;
         case 'closed':
        return Colors.red;
    case 'completed':
        return Colors.blue;
        case 'upcoming':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: event.coverImage != null
                ? Image.network(
                    event.coverImage!,
                    height: size.height * 0.4,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/Intro.png',
                        height: size.height * 0.4,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/Intro.png',
                    height: size.height * 0.4,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      event.title,
                      style: TextStyle(
                        fontSize: size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Acumin',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(event.status.name).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getStatusText(event.status.name),
                      style: TextStyle(
                        color: _getStatusColor(event.status.name),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.015,
              ),
              child: Column(
                children: [
                  InfoRow(
                    icon: Icons.calendar_today,
                    label: "Date".tr,
                    value: _formatDate(event.date),
                  ),
                  InfoRow(
                    icon: LucideIcons.clock,
                    label: "Time".tr,
                    value: event.time,
                  ),
                  InfoRow(
                    icon: Icons.location_on,
                    label: "Location".tr,
                    value: event.location,
                  ),
                  InfoRow(
                    icon: Icons.volunteer_activism,
                    label: "Volunteers".tr,
                    value: "${event.currentVolunteers} / ${event.requiredVolunteers}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
      child: Row(
        children: [
          Icon(icon, size: size.width * 0.05, color: Colors.white),
          SizedBox(width: size.width * 0.03),
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.04,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: size.width * 0.038,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.size,
    this.elevation = 2,
    required this.project,
  });

  final Size size;
  final double? elevation;
  final ProjectModel project;

  String _formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'Active'.tr;
      case 'completed':
        return 'Completed'.tr;
      case 'postponed':
        return 'Postponed'.tr;
      default:
        return 'Unknown'.tr;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
    case 'active':
        return Colors.green;
    case 'completed':
        return Colors.blue;
      case 'postponed':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress = project.donatedAmount / project.targetDonation;

    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: project.coverImage != null
                ? Image.network(
                    project.coverImage!,
                    height: size.height * 0.2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/Intro.png',
                        height: size.height * 0.2,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                : Image.asset(
                    'assets/images/Intro.png',
                    height: size.height * 0.2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    project.name,
                    style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Acumin',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(project.status.name).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getStatusText(project.status.name),
                    style: TextStyle(
                      color: _getStatusColor(project.status.name),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.015,
              ),
              child: Column(
                children:  [
                  InfoRow(
                    icon: Icons.calendar_today,
                    label: "Date".tr,
                    value: "${_formatDate(project.startDate)} - ${_formatDate(project.endDate)}",
                  ),
                  InfoRow(
                    icon: Icons.monetization_on,
                    label: "Target money".tr,
                    value: "${formatNumber(project.targetDonation, Get.locale?.languageCode ?? "en")} \$",
                  ),
                  InfoRow(
                    icon: Icons.people,
                    label: "Volunteers".tr,
                    value: project.totalVolunteers.toString(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24), 
            Column(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Container(
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300], 
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8), 
                        child: LinearProgressIndicator(
                          value: value,
                          backgroundColor: Colors.transparent, 
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 22, 70, 26),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${formatNumber(project.donatedAmount, Get.locale?.languageCode ?? "en")} ${'Donated'.tr}',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${formatNumber(project.remainingAmount, Get.locale?.languageCode ?? "en")} ${'Remaining'.tr}',
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DonateApologizeButton(title: 'Donate'.tr, onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}