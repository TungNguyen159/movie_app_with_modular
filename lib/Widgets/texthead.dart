import 'package:flutter/material.dart';

class TextHead extends StatelessWidget {
  const TextHead({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.maxLines = 1,
  });
  final String text;
  final double fontSize;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
      maxLines: maxLines,
      
    );
  }
}
