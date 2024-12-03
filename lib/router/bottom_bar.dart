import 'dart:ui'; // Needed for BackdropFilter
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20), // Rounded corners if needed
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _goBranch(index);
              });
            },
            currentIndex: widget.navigationShell.currentIndex,
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
