import 'package:flutter/material.dart';
import 'package:movie_app2/core/theme/radius.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    required this.text,

  });
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: radius20,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              text,
              style:const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
