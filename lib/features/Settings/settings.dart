import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/texthead.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHead(text: 'Profile'),
        backgroundColor: const Color.fromARGB(255, 2, 35, 62),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 2, 35, 62),
          
        ),
        child: flutter,
      )
    );
  }
}
