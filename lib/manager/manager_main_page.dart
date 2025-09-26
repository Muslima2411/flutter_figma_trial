import 'package:flutter/material.dart';
import 'package:flutter_figma_trial/manager/main_dashboard_page.dart';
import 'package:flutter_figma_trial/manager/staff_page.dart';
import 'package:flutter_figma_trial/manager/analytics_page.dart';
import 'package:flutter_figma_trial/manager/settings_page.dart';

class ManagerMainPage extends StatefulWidget {
  const ManagerMainPage({super.key});

  @override
  State<ManagerMainPage> createState() => _ManagerMainPageState();
}

class _ManagerMainPageState extends State<ManagerMainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    MainDashboardPage(),
    StaffPage(),
    AnalyticsPage(),
    SettingsPage(),
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
            icon: Icon(Icons.people_alt_outlined),
            activeIcon: _NavPill(icon: Icons.people),
            label: 'Xodimlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            activeIcon: _NavPill(icon: Icons.show_chart),
            label: 'Tahlillar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: _NavPill(icon: Icons.settings),
            label: 'Sozlamalar',
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
