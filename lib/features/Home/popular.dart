import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/config/handle_api.dart';
import 'package:movie_app/features/Home/widgets/grid_movie_item.dart';
import 'package:movie_app/models/movie.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  late Future<List<Movies>> getMovie;

  final controllerApis = controllerApi();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    getMovie = controllerApis.getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const TextHead(
          text: "All movies",
          fontSize: 20,
        ),
        foregroundColor: Colors.white,
      ),
      body: SizedBox(
        child: FutureBuilder(
            future: getMovie,
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                return GridMovieItem(snapshot: snapshot);
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
