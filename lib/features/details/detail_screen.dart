import 'package:flutter/material.dart';
import 'package:movie_app/config/api_handle.dart';
import 'package:movie_app/features/details/widgets/cast_and_crew.dart';
import 'package:movie_app/features/details/widgets/custom_detail.dart';
import 'package:movie_app/features/details/widgets/recommend_movie.dart';
import 'package:movie_app/features/details/widgets/videos_list.dart';
import 'package:movie_app/home.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_detail.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.movieId});
  final int movieId;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<MovieDetail> movieDetails;
  late final Future<Credits> movieCasts;
  late final Future<List<Movies>> recommendMovies;
  late final Future<List<dynamic>> movieVideos;
  @override
  void initState() {
    super.initState();
    movieDetails = ControllerApi().fetchMovieDetail(widget.movieId);
    movieCasts = ControllerApi().fetchCasts(widget.movieId);
    recommendMovies = ControllerApi().recommendMovie(widget.movieId);
    movieVideos = ControllerApi().fetchVideos(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            // Modular.to.navigate("/main/home/");
            Modular.to.pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: FutureBuilder(
                future: movieDetails,
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    );
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return CustomDetail(snapshot: snapshot);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            SizedBox(
              child: FutureBuilder<Credits>(
                future: movieCasts, // Your Future to fetch the movie casts
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final cast = snapshot.data!.cast;

                    return CastAndCrew(cast: cast);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            // SizedBox(
            //   child: FutureBuilder<dynamic>(
            //     future: movieVideos, // Your Future to fetch the movie casts
            //     builder: (ctx, snapshot) {
            //       if (snapshot.hasError) {
            //         return Center(
            //           child: Text(
            //             snapshot.error.toString(),
            //             style: const TextStyle(color: Colors.red),
            //           ),
            //         );
            //       } else if (snapshot.hasData) {
            //         return VideosList(snapshot: snapshot);
            //       } else {
            //         return const Center(child: CircularProgressIndicator());
            //       }
            //     },
            //   ),
            // ),
            SizedBox(
              child: ListDisplay(
                  listFuture: recommendMovies,
                  builder: (snapshot) => RecommendScreen(snapshot: snapshot)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AppButton(
                text: "Get ticket",
                onPressed: () {
                  Modular.to.pushNamed('/main/detail/ticket/${widget.movieId}');
                },
                // onPressed: () async {
                //   final result = await showDialog(
                //     context: context,
                //     builder: (BuildContext context) => const CustomAlertDialog(
                //       title: "Alert",
                //       description:
                //           "this movie not in onshowing still booking ?",
                //       confirmText: "continue",
                //       cancelText: "cancel",
                //     ),
                //   );
                //   if (result == true) {
                //     Modular.to.pushNamed(
                //       '/main/detail/ticket/${widget.movieId}',
                //     );
                //   } else {
                //     Navigator.of(context).pop;
                //   }
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
