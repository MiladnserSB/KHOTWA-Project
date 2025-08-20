import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_Page_Volunteer.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';
import 'package:khotwa/view/event_and_projects/my_events_page.dart';
import 'package:khotwa/view/login/login_page.dart';
import 'package:khotwa/view/profile/profile_page.dart';
import 'package:khotwa/view/settings/settings_page.dart';
import 'package:khotwa/view/tasks/tasks_page.dart';

class AnimatedBottomBarPageSupervisor extends StatefulWidget {
  @override
  _AnimatedBottomBarPageSupervisorState createState() =>
      _AnimatedBottomBarPageSupervisorState();
}

class _AnimatedBottomBarPageSupervisorState
    extends State<AnimatedBottomBarPageSupervisor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 2;
  String _selectedDrawerItem = '';

  final List<_NavItem> _items = [
    _NavItem(icon: Icons.menu, label: 'Menu'),
    _NavItem(icon: Icons.event_note_sharp, label: 'My events'),
    _NavItem(icon: Icons.home, label: 'Home'),
    _NavItem(icon: Icons.event, label: 'Projects,Events'),
    _NavItem(icon: Icons.task, label: 'Tasks'),
  ];

  final List<Widget> _pages = [
    SizedBox(),
    MyEventsPage(),
    HomePageVolunteer(),
    EventsAndProjectsPage(),
    TasksPage(),
  ];

  void _onIconTap(int index) {
    if (_items[index].label == 'Menu') {
      Future.delayed(Duration(milliseconds: 100), () {
        _scaffoldKey.currentState?.openDrawer();
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: theme.scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/drawer.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDrawerItem = 'Profile';
                      });
                      Get.to(ProfilePage());
                    },
                    child: const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/images/person.jpg'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'User',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const Text(
                    'User@gmail.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.person,
              label: 'Profile',
              page: ProfilePage(),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              label: 'Settings',
              page: SettingsPage(),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.info_outline,
              label: 'About Us',
              page: const Placeholder(),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: _selectedDrawerItem == 'Logout'
                    ? const Color(0xFFDDA15E)
                    : theme.iconTheme.color,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  color: _selectedDrawerItem == 'Logout'
                      ? const Color(0xFFDDA15E)
                      : theme.textTheme.bodyMedium?.color,
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: theme.scaffoldBackgroundColor,
                    title: Text(
                      "Confirm Logout",
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                    content: Text(
                      "Are you sure you want to log out?",
                      style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _selectedDrawerItem = 'Logout';
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: theme.bottomNavigationBarTheme.backgroundColor ??
              theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.white10 : Colors.black12,
              blurRadius: 4,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final isSelected = index == _selectedIndex;

            return GestureDetector(
              onTap: () => _onIconTap(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: 26,
                    color: isSelected
                        ? const Color(0xFFDDA15E)
                        : theme.iconTheme.color,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? const Color(0xFFDDA15E)
                          : theme.textTheme.bodyMedium?.color,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String label,
      required Widget page}) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(
        icon,
        color: _selectedDrawerItem == label
            ? const Color(0xFFDDA15E)
            : theme.iconTheme.color,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: _selectedDrawerItem == label
              ? const Color(0xFFDDA15E)
              : theme.textTheme.bodyMedium?.color,
          fontWeight: _selectedDrawerItem == label
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedDrawerItem = label;
        });
        Get.to(page);
      },
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem({required this.icon, required this.label});
}
