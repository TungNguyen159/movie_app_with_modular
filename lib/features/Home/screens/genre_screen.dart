import 'package:flutter/material.dart';
import 'package:movie_app2/detail.dart';
import 'package:movie_app2/features/Home/widgets/grid_movie_item.dart';
import 'package:movie_app2/models/genres.dart';
import 'package:movie_app2/service/movie_service.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  late Genres genre;
  final movieService = MovieService();
  @override
  void initState() {
    super.initState();
    genre = Modular.args.data["genres"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextHead(text: genre.name),
      ),
      body: ListDisplay(
          listFuture: movieService.getmoviebygen(genre.id!),
          builder: (genre) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                  childAspectRatio: 0.7,
                ),
                itemCount: genre.length,
                itemBuilder: (ctx, index) {
                  final genresList = genre[index];
                  return GridMovieItem(movies: genresList);
                });
          }),
    );
  }
}
