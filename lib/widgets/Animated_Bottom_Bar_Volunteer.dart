import 'package:flutter/material.dart';
import 'package:khotwa/view/Home_Page/Home_Page_Visitor.dart';
import 'package:khotwa/view/Home_Page/Home_Page_Volunteer.dart';
import 'package:khotwa/view/intro/Intro_Screen.dart';
import 'package:khotwa/view/login/login_page.dart';

class AnimatedBottomBarPageVolunteer extends StatefulWidget {
  @override
  _AnimatedBottomBarPageVolunteerState createState() =>
      _AnimatedBottomBarPageVolunteerState();
}

class _AnimatedBottomBarPageVolunteerState
    extends State<AnimatedBottomBarPageVolunteer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 4; // Default to "Home"

  final List<_NavItem> _items = [
    _NavItem(icon: Icons.menu, label: 'Menu'),
    _NavItem(icon: Icons.receipt_long, label: 'Volunteer Log'),
    _NavItem(icon: Icons.task, label: 'Tasks'),
    _NavItem(icon: Icons.notifications, label: 'Notifications'),
    _NavItem(icon: Icons.home, label: 'Home'),
  ];

  void _onIconTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_items[index].label) {
      case 'Menu':
        Future.delayed(Duration(milliseconds: 100), () {
          _scaffoldKey.currentState?.openDrawer();
        });
        break;

      case 'Volunteer Log':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()), // Replace with actual Volunteer Log page
        );
        break;

      case 'Tasks':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()), // Replace with actual Tasks page
        );
        break;

      case 'Notifications':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()), // Replace with actual Notifications page
        );
        break;

      case 'Home':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageVoulunteer()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFDDA15E)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Khotwa Team',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat'),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About Us'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: HomePageVoulunteer(), // Displays Home by default
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
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
                    color: isSelected ? Color(0xFFDDA15E) : Colors.grey,
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Color(0xFFDDA15E) : Colors.grey,
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
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem({required this.icon, required this.label});
}
