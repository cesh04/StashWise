import 'package:flutter/material.dart';
import 'package:stashwise/pages/home.dart';// Home page
import 'package:stashwise/pages/analytics.dart'; // Analytics page
import 'package:stashwise/pages/settings.dart'; // Settings page

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 1; // Default to Home page

  // Pages for navigation
  static final List<Widget> _pages = <Widget>[
    AnalyticsPage(),
    Home(), // Home is index 1
    SettingsPage(),
  ];

  // Handle BottomNavigationBar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'StashWise',
            style: TextStyle(
              fontFamily: 'Lobster Two',
              fontWeight: FontWeight.w800,
              color: Color(0xFF080708),
              fontSize: 28.0,
            ),
          ),
        ),
      ),
      // The body will be the page that is selected in the BottomNavigationBar
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF1F62FF),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        iconSize: 28,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
