import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextHead(text: 'favorite'),
        centerTitle: true,
      ),
    );
  }
}
