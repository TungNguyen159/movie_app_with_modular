import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/app_elevated_button.dart';
import 'package:movie_app/config/api_handle.dart';
import 'package:movie_app/core/theme/gap.dart';
import 'package:movie_app/features/Home/popular.dart';
import 'package:movie_app/features/Home/widgets/custom_card_movie.dart';
import 'package:movie_app/features/Home/widgets/custom_card_thumnail.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/features/authentication/sign_in_screen.dart';
import 'package:movie_app/models/movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movies>> popularMovie;
  late Future<List<Movies>> topRatedMovie;
  late Future<List<Movies>> upComingMovie;
  late Future<List<Movies>> nowPlaying;

  final controllerApis = ControllerApi();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    popularMovie = controllerApis.getPopularMovie();
    topRatedMovie = controllerApis.getTopRatedMovie();
    upComingMovie = controllerApis.getUpComingMovie();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hi Jack!',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => SignInScreen()));
                        },
                        child: const CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage(
                            'https://static.vecteezy.com/system/resources/thumbnails/007/209/020/small_2x/close-up-shot-of-happy-dark-skinned-afro-american-woman-laughs-positively-being-in-good-mood-dressed-in-black-casual-clothes-isolated-on-grey-background-human-emotions-and-feeligs-concept-photo.jpg',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap.mdHeight,
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
                  Gap.mdHeight,
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
                  Gap.mdHeight,
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
                  Gap.mdHeight,
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
                  Center(
                    child: AppElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => PopularScreen(),
                          ),
                        );
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
    );
  }
}
