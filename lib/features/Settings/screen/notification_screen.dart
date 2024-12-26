import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("notificaitons"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            //  Modular.to.navigate("/main/setting");
            Modular.to.pop();
          },
        ),
      ),
    );
  }
}
