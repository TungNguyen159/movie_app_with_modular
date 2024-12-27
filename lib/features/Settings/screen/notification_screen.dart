import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/Widgets/back_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("notificaitons"),
        leading: BackBind(
          onPressed: () {
            //  Modular.to.navigate("/main/setting");
            Modular.to.pop();
          },
        ),
      ),
    );
  }
}
