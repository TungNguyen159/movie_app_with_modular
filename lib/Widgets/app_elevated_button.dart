import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.textColor = Colors.white,
      this.bgColor = const Color.fromARGB(255, 26, 73, 111)});

  final Function()? onPressed;
  final String text;
  final Color textColor;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(bgColor),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 20.0),
      ),
    );
  }
}
