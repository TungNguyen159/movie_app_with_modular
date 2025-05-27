import 'package:flutter/material.dart';

class RealtimeDisplay<T> extends StatelessWidget {
  final Stream<List<T>> listStream;
  final Widget Function(List<T> data) builder;
  const RealtimeDisplay(
      {super.key, required this.listStream, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: listStream,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            snapshot.error.toString(),
            style: const TextStyle(color: Colors.red),
          ));
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          if (data.isEmpty) {
            return Center(
              child: Text(
                "Không có dữ liệu",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            );
          }
          return builder(data);
        } else {
          return Center(
              child: Text(
            "No data available",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ));
        }
      },
    );
  }
}
