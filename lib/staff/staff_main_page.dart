import 'package:flutter/material.dart';
import 'package:flutter_figma_trial/manager/main_dashboard_page.dart';
import 'package:flutter_figma_trial/manager/staff_page.dart';
import 'package:flutter_figma_trial/manager/analytics_page.dart';
import 'package:flutter_figma_trial/manager/settings_page.dart';
import 'package:flutter_figma_trial/staff/profile_page.dart';
import 'package:flutter_figma_trial/staff/staff_home_page.dart';

import 'info_page.dart';

class StaffMainPage extends StatefulWidget {
  const StaffMainPage({super.key});

  @override
  State<StaffMainPage> createState() => _ManagerMainPageState();
}

class _ManagerMainPageState extends State<StaffMainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    StaffHomePage(),
    InfoPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        // Keep labels always black
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            activeIcon: _NavPill(icon: Icons.dashboard),
            label: 'Asosiy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            activeIcon: _NavPill(icon: Icons.star),
            label: 'Ma\'lumotlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            activeIcon: _NavPill(icon: Icons.person_2_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

/// Rounded teal pill for the active icon only.
class _NavPill extends StatelessWidget {
  final IconData icon;
  const _NavPill({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: Colors.white), // icon white, label unaffected
    );
  }
}
