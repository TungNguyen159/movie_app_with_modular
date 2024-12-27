import 'package:flutter/material.dart';

class ListDisplay<T> extends StatelessWidget {
  final Future<List<T>> listFuture;
  final Widget Function(AsyncSnapshot<List<T>>) builder;
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
          return builder(snapshot);
        } else {
          return Center(
              child: Text(
            "No data available",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ));
        }
      },
    );
  }
}
