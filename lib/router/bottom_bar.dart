import 'dart:ui'; // Needed for BackdropFilter
import 'package:flutter/material.dart';
import 'package:movie_app2/features/Yourbooking/booked_screen.dart';
import 'package:movie_app2/features/Home/screens/home_screen.dart';
import 'package:movie_app2/features/Onshowing/onshowing_screen.dart';
import 'package:movie_app2/features/Search/search_screen.dart';
import 'package:movie_app2/features/Settings/screen/setting_screen.dart';

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
    const BookedScreen(),
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
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effect
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            backgroundColor: Theme.of(context)
                .colorScheme
                .surface, // Semi-transparent background
            selectedItemColor: Theme.of(context).colorScheme.primary, // Selected item color
            unselectedItemColor: Theme.of(context).colorScheme.tertiary, // Unselected item color
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
                icon: Icon(Icons.book_online),
                label: 'Booking',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
