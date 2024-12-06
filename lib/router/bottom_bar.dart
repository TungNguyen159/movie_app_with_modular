import 'dart:ui'; // Needed for BackdropFilter
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
  });
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  final List<String> _routes = [
    "/home",
    "/favorite",
    "/search",
    "/setting",
  ];
  @override
  void initState() {
    super.initState();
    Modular.to
        .navigate(_routes[_currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:const RouterOutlet(),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Rounded corners if needed
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              Modular.to.navigate(_routes[index]);
            },
            currentIndex: _currentIndex,
            backgroundColor:
                Colors.black.withOpacity(0.5), // Semi-transparent background
            selectedItemColor: Colors.white, // Selected item color
            unselectedItemColor: Colors.grey, // Unselected item color
            type: BottomNavigationBarType.fixed, // Keep labels visible
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
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
