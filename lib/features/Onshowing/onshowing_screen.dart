import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';

class OnshowingScreen extends StatefulWidget {
  const OnshowingScreen({super.key});

  @override
  State<OnshowingScreen> createState() => _OnshowingScreenState();
}

class _OnshowingScreenState extends State<OnshowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextHead(text: "Onshowing"),
      ),
    );
  }
}