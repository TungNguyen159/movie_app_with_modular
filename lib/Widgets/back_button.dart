import 'package:flutter/material.dart';

class BackBind extends StatelessWidget {
  const BackBind({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios,
          color: Theme.of(context).colorScheme.onPrimary),
      onPressed: onPressed,
    );
  }
}
