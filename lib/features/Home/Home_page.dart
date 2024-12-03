import 'package:flutter/material.dart';
import 'package:movie_app/features/Home/widgets/custom_card_movie.dart';
import 'package:movie_app/features/Home/widgets/custom_card_thumnail.dart';
import 'package:movie_app/Widgets/texthead.dart';
import 'package:movie_app/core/config/handle_api.dart';
import 'package:movie_app/models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movies>> popularMovie;
  late Future<List<Movies>> topRatedMovie;
  late Future<List<Movies>> upComingMovie;
  late Future<List<Movies>> nowPlaying;

  final controllerApis = controllerApi();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    popularMovie = controllerApis.getPopularMovie();
    topRatedMovie = controllerApis.getListMovie();
    upComingMovie = controllerApis.getUpcomingMovie();
    nowPlaying = controllerApis.getNowPlayingMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi Jack!',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(
                          'https://static.vecteezy.com/system/resources/thumbnails/007/209/020/small_2x/close-up-shot-of-happy-dark-skinned-afro-american-woman-laughs-positively-being-in-good-mood-dressed-in-black-casual-clothes-isolated-on-grey-background-human-emotions-and-feeligs-concept-photo.jpg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    child: FutureBuilder(
                        future: popularMovie,
                        builder: (ctx, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return CustomCardThumbnail(snapshot: snapshot);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ),
                  const SizedBox(height: 15),
                  const TextHead(text: 'Top rated'),
                  SizedBox(
                    child: FutureBuilder(
                        future: topRatedMovie,
                        builder: (ctx, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return CustomCardMovie(snapshot: snapshot);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ),
                  const SizedBox(height: 15),
                  const TextHead(text: "Now playing"),
                  SizedBox(
                    child: FutureBuilder(
                        future: nowPlaying,
                        builder: (ctx, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return CustomCardMovie(snapshot: snapshot);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ),
                  const SizedBox(height: 15),
                  const TextHead(text: "Upcoming"),
                  SizedBox(
                    child: FutureBuilder(
                        future: upComingMovie,
                        builder: (ctx, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          } else if (snapshot.hasData) {
                            return CustomCardMovie(snapshot: snapshot);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
