import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/list_display.dart';
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
        title: const TextHead(text: "Onshowing"),
      ),
      body: ListDisplay(
        listFuture: onShowingList,
        builder: (snapshot) => OnshowingListItem(snapshot: snapshot),
      ),
    );
  }
}
