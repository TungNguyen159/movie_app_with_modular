import 'package:flutter/material.dart';

class ListDisplay<T> extends StatelessWidget {
  final Future<List<T>> listFuture;
  final Widget Function(List<T> data) builder;
  const ListDisplay({
    super.key,
    required this.listFuture,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: listFuture,
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
