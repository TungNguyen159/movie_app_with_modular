import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ManageStatitics extends StatefulWidget {
  const ManageStatitics({super.key});

  @override
  State<ManageStatitics> createState() => _ManageStatiticsState();
}

class _ManageStatiticsState extends State<ManageStatitics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistic"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.stacked_bar_chart, color: Colors.blue),
              title: const Text("statistic month"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Modular.to.pushNamed("/manage/statistic/month"),
            ),
            ListTile(
              leading: const Icon(Icons.stacked_line_chart, color: Colors.blue),
              title: const Text("statistic movie"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Modular.to.pushNamed("/manage/statistic/movie"),
            ),
          ],
        ),
      ),
    );
  }
}
