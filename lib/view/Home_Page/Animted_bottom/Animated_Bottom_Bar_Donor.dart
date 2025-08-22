import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_Page_Donor.dart';
import 'package:khotwa/view/change_password/change_password_page.dart';
import 'package:khotwa/view/settings/settings_page.dart';

class AnimatedBottomBarPageDonor extends StatefulWidget {
  @override
  _AnimatedBottomBarPageDonorState createState() =>
      _AnimatedBottomBarPageDonorState();
}

class _AnimatedBottomBarPageDonorState
    extends State<AnimatedBottomBarPageDonor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 1; 
  String _selectedDrawerItem = '';

  final List<_NavItem> _items = [
    _NavItem(icon: Icons.menu, label: 'menu'.tr),
    _NavItem(icon: Icons.home, label: 'home'.tr),
    _NavItem(icon: Icons.volunteer_activism, label: 'donate'.tr),
    _NavItem(icon: Icons.shopping_cart, label: 'cart'.tr),
  ];

  final List<Widget> _pages = [
    SizedBox(),
    HomePageDonor(),
    ChangingPasswordPage(),
    ChangingPasswordPage(),
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
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/person.jpg'),
                  ),
                  const SizedBox(height: 10),
                  Text('user name'.tr,
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('user email'.tr,
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            _buildDrawerItem(icon: Icons.settings, label: 'settings'.tr, page: SettingsPage()),
            _buildDrawerItem(icon: Icons.info_outline, label: 'about us'.tr, page: const Placeholder()),
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
                  Icon(item.icon,
                      color: isSelected
                          ? const Color(0xFFDDA15E)
                          : theme.iconTheme.color),
                  const SizedBox(height: 4),
                  Text(item.label,
                      style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? const Color(0xFFDDA15E)
                              : theme.textTheme.bodyMedium?.color,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String label, required Widget page}) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon,
          color: _selectedDrawerItem == label
              ? const Color(0xFFDDA15E)
              : theme.iconTheme.color),
      title: Text(label,
          style: TextStyle(
              color: _selectedDrawerItem == label
                  ? const Color(0xFFDDA15E)
                  : theme.textTheme.bodyMedium?.color,
              fontWeight: _selectedDrawerItem == label
                  ? FontWeight.bold
                  : FontWeight.normal)),
      onTap: () {
        setState(() {
          _selectedDrawerItem = label;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  _NavItem({required this.icon, required this.label});
}
