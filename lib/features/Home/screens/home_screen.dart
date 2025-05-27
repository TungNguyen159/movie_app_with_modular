import 'package:flutter/material.dart';
import 'package:movie_app2/home.dart';
import 'package:movie_app2/service/genres_service.dart';
import 'package:movie_app2/service/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final movieService = MovieService();
  final genresService = GenresService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///list movies
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Gap.mL, vertical: Gap.mL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeHeader(),
                    Gap.mdHeight,
                    SizedBox(
                      child: ListDisplay(
                        listFuture: movieService.getmovie(),
                        builder: (snapshot) =>
                            CustomCardThumbnail(snapshot: snapshot),
                      ),
                    ),
                    Gap.mdHeight,
                    const Center(child: TextHead(text: "Genres")),
                    Gap.mdHeight,
                    SizedBox(
                      child: ListDisplay(
                        listFuture: genresService.getGenres(),
                        builder: (genre) => GridGenreItem(genres: genre),
                      ),
                    ),
                    Gap.mdHeight,
                    const Center(child: TextHead(text: "Best movies")),
                    SizedBox(
                      child: ListDisplay(
                        listFuture: movieService.getmovie(),
                        builder: (snapshot) =>
                            CustomCardMovie(snapshot: snapshot),
                      ),
                    ),
                    Gap.mdHeight,
                    Center(
                      child: AppButton(
                        onPressed: () {
                          Modular.to.navigate("/home/seeAll");
                        },
                        text: "See all",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
