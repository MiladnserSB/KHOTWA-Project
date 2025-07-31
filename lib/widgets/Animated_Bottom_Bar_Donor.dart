import 'package:flutter/material.dart';
import 'package:khotwa/view/Home_Page/Home_Page_Donor.dart';
import 'package:khotwa/view/intro/Intro_Screen.dart';

class AnimatedBottomBarPageDonor extends StatefulWidget {
  @override
  _AnimatedBottomBarPageDonorState createState() => _AnimatedBottomBarPageDonorState();
}

class _AnimatedBottomBarPageDonorState extends State<AnimatedBottomBarPageDonor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 4;

  final List<_NavItem> _items = [
    _NavItem(icon: Icons.menu, label: 'Menu'),
    // _NavItem(icon: Icons.login, label: 'Logout'),
    _NavItem(icon: Icons.volunteer_activism, label: 'Donate'),
    _NavItem(icon: Icons.shopping_cart, label: 'Cart'),
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

//       case 'Logout':
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Confirm Logout",  style: TextStyle(        fontWeight: FontWeight.bold,

// )
// ),
//               content: Text("Are you sure you want to logout?"),
//               actions: [
//                 TextButton(
//                   child: Text("No",style: TextStyle(color: Color(0xFFDDA15E))),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 TextButton(
//                   child: Text("yes",style: TextStyle(color: Color(0xFFDDA15E))),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginPage()),
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//         break;

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

      case 'Home':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageDonor()),
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
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
             ListTile(
              leading: Icon(Icons.receipt_long),
              title: Text('Log'),
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
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
