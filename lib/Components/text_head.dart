import 'package:flutter/material.dart';

class TextHead extends StatelessWidget {
  const TextHead({
    super.key,
    required this.text,
    this.maxLines = 1,
    this.textStyle,
  });

  final String text;
  final TextStyle? textStyle; // Make textStyle nullable
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle = textStyle ??
        Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold);

    return Text(
      text,
      style: defaultTextStyle,
      maxLines: maxLines,
    );
  }
}
