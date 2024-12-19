import 'dart:ui'; // Needed for BackdropFilter
import 'package:flutter/material.dart';
import 'package:movie_app/features/Checking/Checking_screen.dart';
import 'package:movie_app/features/Notifications/notification_screen.dart';
import 'package:movie_app/features/Home/home_screen.dart';
import 'package:movie_app/features/Onshowing/onshowing_screen.dart';
import 'package:movie_app/features/Search/search_screen.dart';
import 'package:movie_app/features/Settings/setting_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  final List<Widget> _screen = [
    const HomeScreen(),
    const OnshowingScreen(),
    const SearchScreen(),
    const SeatScreen(movie: {},),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screen,
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            backgroundColor:
                Colors.black, // Semi-transparent background
            selectedItemColor: Colors.white, // Selected item color
            unselectedItemColor: Colors.grey, // Unselected item color
            type: BottomNavigationBarType.fixed, // Keep labels visible
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.ondemand_video_outlined),
                label: 'Onshowing',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notification',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
