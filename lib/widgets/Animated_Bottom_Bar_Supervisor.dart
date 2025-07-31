import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Home_Page_Volunteer.dart';
import 'package:khotwa/view/intro/Intro_Screen.dart';
import 'package:khotwa/view/login/login_page.dart';

class AnimatedBottomBarPageSupervisor extends StatefulWidget {
  @override
  _AnimatedBottomBarPageSupervisorState createState() =>
      _AnimatedBottomBarPageSupervisorState();
}

class _AnimatedBottomBarPageSupervisorState
    extends State<AnimatedBottomBarPageSupervisor> {




  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 4;

  String _selectedDrawerItem = '';

  final List<_NavItem> _items = [
    _NavItem(icon: Icons.menu, label: 'Menu'),
    _NavItem(icon: Icons.event_note_sharp, label: 'My events'),
    _NavItem(icon: Icons.home, label: 'Home'),
    _NavItem(icon: Icons.event, label: 'Projects,Events'),
    _NavItem(icon: Icons.task, label: 'Tasks'),
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

      case 'My events':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
        break;

      case 'Home':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
        break;

      case 'Projects,Events':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
        break;

      case 'Tasks':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageVolunteer()),
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
              decoration: BoxDecoration(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePageVolunteer()),
                      );
                    },
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/images/person.jpg'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'User',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'User@gmail.com',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person,
                  color: _selectedDrawerItem == 'Profile'
                      ? Color(0xFFDDA15E)
                      : Colors.black),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: _selectedDrawerItem == 'Profile'
                      ? Color(0xFFDDA15E)
                      : Colors.black,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedDrawerItem = 'Profile';
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageVolunteer()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: _selectedDrawerItem == 'Settings'
                      ? Color(0xFFDDA15E)
                      : Colors.black),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: _selectedDrawerItem == 'Settings'
                      ? Color(0xFFDDA15E)
                      : Colors.black,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedDrawerItem = 'Settings';
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline,
                  color: _selectedDrawerItem == 'About Us'
                      ? Color(0xFFDDA15E)
                      : Colors.black),
              title: Text(
                'About Us',
                style: TextStyle(
                  color: _selectedDrawerItem == 'About Us'
                      ? Color(0xFFDDA15E)
                      : Colors.black,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedDrawerItem = 'About Us';
                });
              },
            ),
            ListTile(
  leading: Icon(Icons.logout,
      color: _selectedDrawerItem == 'Logout'
          ? Color(0xFFDDA15E)
          : Colors.black),
  title: Text(
    'Logout',
    style: TextStyle(
      color: _selectedDrawerItem == 'Logout'
          ? Color(0xFFDDA15E)
          : Colors.black,
    ),
  ),
  onTap: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Logout",style: TextStyle(color:primaryColor,    fontWeight: FontWeight.bold,
  )),
        content: Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel",style: TextStyle(color:primaryColor,    
  )),
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
            child: Text(
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
      body: HomePageVolunteer(),
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
