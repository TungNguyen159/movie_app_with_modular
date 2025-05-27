import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/app_button.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(), // đẩy phần giữa xuống giữa màn hình
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline_outlined,
                  size: 70,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),
                Text(
                  "Your ticket has been booked",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          const Spacer(), // đẩy phần giữa lên giữa
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AppButton(
              text: "Go to home",
              onPressed: () {
                Modular.to.navigate("/main");
              },
            ),
          ),
        ],
      ),
    );
  }
}
