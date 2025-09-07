import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/base_url.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/About_page.dart';
import 'package:khotwa/view/Home_Page/Cards/donor_login_dialog.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_Page_Visitor.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';
import 'package:khotwa/view/settings/settings_page.dart';

class AnimatedBottomBarPageVisitor extends StatefulWidget {
  @override
  _AnimatedBottomBarPageVisitorState createState() =>
      _AnimatedBottomBarPageVisitorState();
}

class _AnimatedBottomBarPageVisitorState
    extends State<AnimatedBottomBarPageVisitor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 1;
  String _selectedDrawerItem = '';
  

  final List<_NavItem> _items = [
    _NavItem(icon: Icons.menu, label: 'menu'.tr),
    _NavItem(icon: Icons.home, label: 'home'.tr),
    _NavItem(icon: Icons.login, label: 'register'.tr),
    _NavItem(icon: Icons.event, label: 'projects events'.tr),
    // _NavItem(icon: Icons.volunteer_activism, label: 'My Donation'.tr),
  ];

  final List<Widget> _pages = [
    SizedBox(),
    HomePageVisitor(),
    DonorLoginDialog(),
    EventsAndProjectsPage(),
    // MyDonationsPage(),
  ];

  void _onIconTap(int index) {
    if (_items[index].label == 'menu'.tr) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scaffoldKey.currentState?.openDrawer();
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onDrawerItemTap(String item, Widget page) {
    setState(() {
      _selectedDrawerItem = item;
    });
    Navigator.push(context, MaterialPageRoute(builder: (_) => page)).then((_) {
      setState(() {
        _selectedDrawerItem = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    roleID=-1;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: theme.brightness == Brightness.dark
            ? Colors.black
            : thirdColor,
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
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/person.jpg'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'user name'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'user email'.tr,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: _selectedDrawerItem == 'settings'.tr
                    ? const Color(0xFFDDA15E)
                    : theme.iconTheme.color,
              ),
              title: Text(
                'settings'.tr,
                style: TextStyle(
                  color: _selectedDrawerItem == 'settings'.tr
                      ? const Color(0xFFDDA15E)
                      : theme.textTheme.bodyMedium?.color,
                  fontWeight: _selectedDrawerItem == 'settings'.tr
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () => _onDrawerItemTap('settings'.tr, SettingsPage()),
            ),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: _selectedDrawerItem == 'about_us'.tr
                    ? const Color(0xFFDDA15E)
                    : theme.iconTheme.color,
              ),
              title: Text(
                'about us'.tr,
                style: TextStyle(
                  color: _selectedDrawerItem == 'about_us'.tr
                      ? const Color(0xFFDDA15E)
                      : theme.textTheme.bodyMedium?.color,
                  fontWeight: _selectedDrawerItem == 'about_us'.tr
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () => _onDrawerItemTap('about_us'.tr, const AboutPage()),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color:
              theme.bottomNavigationBarTheme.backgroundColor ??
              theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.white10 : Colors.black12,
              blurRadius: 4,
            ),
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
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
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
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem({required this.icon, required this.label});
}
