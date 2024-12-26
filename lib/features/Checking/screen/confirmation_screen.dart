import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/Widgets/app_button.dart';
import 'package:movie_app/Widgets/text_head.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(),
            const TextHead(text: "Your ticket have been booked"),
            const Spacer(),
            AppButton(
              text: "Go to home",
              onPressed: () {
               Modular.to.navigate("/main");
              },
            )
          ],
        ),
      ),
    );
  }
}
