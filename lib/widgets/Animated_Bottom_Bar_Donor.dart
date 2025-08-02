import 'package:flutter/material.dart';
import 'package:khotwa/view/Home_Page/Home_Page_Donor.dart';
import 'package:khotwa/view/Home_Page/Home_Page_Volunteer.dart';
import 'package:khotwa/view/intro/Intro_Screen.dart';
import 'package:khotwa/view/login/login_page.dart';

class AnimatedBottomBarPageDonor extends StatefulWidget {
  @override
  _AnimatedBottomBarPageDonorState createState() => _AnimatedBottomBarPageDonorState();
}

class _AnimatedBottomBarPageDonorState extends State<AnimatedBottomBarPageDonor> {

   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 4; 
  String _selectedDrawerItem = '';

  final List<_NavItem> _items = [
    _NavItem(icon: Icons.menu, label: 'Menu'),
    _NavItem(icon: Icons.login, label: 'Login'),
    _NavItem(icon: Icons.home, label: 'Home'), 
    _NavItem(icon: Icons.volunteer_activism, label: 'Donate'),
    _NavItem(icon: Icons.shopping_cart, label: 'Cart'),
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
      case 'Login':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        break;
         case 'Home':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageDonor()),
        );
        break;
      case 'Donate':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
        break;
      case 'Cart':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
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
                            builder: (context) => HomePageDonor()),
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
           

          ],
        ),
      ),
      body: HomePageDonor(),
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
