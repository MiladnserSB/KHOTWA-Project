import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/event_and_projects/donate_apologize_button.dart';
import 'package:khotwa/view/event_and_projects/event_details/event_details_page.dart';
import 'package:khotwa/view/event_and_projects/project_details/project_details_page.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class EventsAndProjectsPage extends StatefulWidget {
  const EventsAndProjectsPage({super.key});

  @override
  State<EventsAndProjectsPage> createState() => _EventsAndProjectsPageState();
}

class _EventsAndProjectsPageState extends State<EventsAndProjectsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
             Container(
  width: double.infinity, 
  height: 50,
  padding: const EdgeInsets.all(4),
  decoration: BoxDecoration(
    color:         theme.brightness == Brightness.dark ? Color.fromARGB(255, 77, 75, 75) : Colors.white,

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
        tabs: const [
          Tab(text: 'Events'),
          Tab(text: 'Projects'),
        ],
      ),
    ),
  ],
)


)

,
                SizedBox(height: size.height * 0.04),
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
                        child: const Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.search,color: Colors.black,size: 20,),
                                                    SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                counterStyle: TextStyle(color: Colors.black),
                                hintText: 'Search...',
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
                SizedBox(height: size.height * 0.02),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      AnimatedListView(
                        size: size,
                        itemHeight: itemHeight,
                        isEvent: true,
                      ),
                      AnimatedListView(
                        size: size,
                        itemHeight: itemHeight,
                        isEvent: false,
                      ),
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
  });

  final Size size;
  final double itemHeight;
  final bool isEvent;

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
    return ListView.separated(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        double scale = _calculateScale(index);
        return Transform.scale(
          scale: scale,
          child: widget.isEvent
              ? GestureDetector(
                  onTap: () {
                    Get.to(EventDetailsPage());
                  },
                  child: EventCard(
                    size: widget.size,
                    elevation: scale > 0.98 ? 10 : 2, title: '',
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Get.to(ProjectDetailsPage());
                  },
                  child: ProjectCard(
                    size: widget.size,
                    elevation: scale > 0.98 ? 10 : 2,
                    donatedAmount: 10000,
                    totalAmount: 15000,
                  ),
                ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.size, this.elevation = 2, required String title});

  final Size size;
  final double elevation;

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
              child: Image.asset(
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
                      'Event Title Goes Here',
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
                      color: secondaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        color: secondaryColor,
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
                children: const [
                  InfoRow(
                    icon: Icons.calendar_today,
                    label: "Date",
                    value: "16.04.2024 - 16.08.2024",
                  ),
                  InfoRow(
                    icon: LucideIcons.clock,
                    label: "Time",
                    value: "10:00 AM - 4:00 PM",
                  ),
                  InfoRow(
                    icon: Icons.location_on,
                    label: "Location",
                    value: "Kharkiv, Ukraine",
                  ),
                  InfoRow(
                    icon: Icons.volunteer_activism,
                    label: "Volunteers",
                    value: "150 / 200",
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
    required this.totalAmount,
    required this.donatedAmount,
  });

  final Size size;
  final double? elevation;
  final double totalAmount; 
  final double donatedAmount;

  @override
  Widget build(BuildContext context) {
    final double remainingAmount = totalAmount - donatedAmount;
    final double progress = donatedAmount / totalAmount;

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
              child: Image.asset(
                'assets/images/Intro.png',
                height: size.height * 0.2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Event Title Goes Here',
              style: TextStyle(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
                fontFamily: 'Acumin',
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 24),
            SizedBox(width: 10),
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
                children: const [
                  InfoRow(
                    icon: Icons.calendar_today,
                    label: "Date",
                    value: "16.04.2024 - 16.08.2024",
                  ),
                  InfoRow(
                    icon: LucideIcons.clock,
                    label: "Time",
                    value: "10:00 AM - 4:00 PM",
                  ),
                  InfoRow(
                    icon: Icons.monetization_on,
                    label: "Target money",
                    value: "15000 \$",
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
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                        color: Colors.grey[300], 
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8,
                        ), 
                        child: LinearProgressIndicator(
                          value: value,
                          backgroundColor:
                              Colors.transparent, 
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
                      '${donatedAmount.toStringAsFixed(2)} Donated',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${remainingAmount.toStringAsFixed(2)} Remaining',
                      style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DonateApologizeButton(title: 'Donate', onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
