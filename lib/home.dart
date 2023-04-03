import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:merchant/account_page.dart';
import 'package:merchant/booking_page.dart';
import 'package:merchant/home_page.dart';
import 'package:merchant/login.dart';

import 'helpers/shared_preference_service.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var _selectedIndex = 0;
  final SharedPreferenceService prefService = SharedPreferenceService();

  void _navigageBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    BookingPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              onTabChange: (value) => {_navigageBottomBar(value)},
              padding: EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.list_alt,
                  text: "Bookings",
                ),
                GButton(
                  icon: Icons.person,
                  text: "Account",
                  onPressed: () {
                    prefService.updateLoginStatus(false);
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
