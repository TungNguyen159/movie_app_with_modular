import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/config/api_handle.dart';
import 'package:movie_app/features/Onshowing/widgets/onshowing_list_item.dart';
import 'package:movie_app/models/movie.dart';

class OnshowingScreen extends StatefulWidget {
  const OnshowingScreen({super.key});

  @override
  State<OnshowingScreen> createState() => _OnshowingScreenState();
}

class _OnshowingScreenState extends State<OnshowingScreen> {
  late Future<List<Movies>> onShowingList;
  final controllerApis = ControllerApi();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    onShowingList = controllerApis.getPopularMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextHead(text: "Onshowing"),
      ),
      body: FutureBuilder(
          future: onShowingList,
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return OnshowingListItem(snapshot: snapshot);
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
