import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/app_elevated_button.dart';
import 'package:movie_app/features/details/widgets/cast_and_crew.dart';
import 'package:movie_app/features/details/widgets/custom_detail.dart';
import 'package:movie_app/config/handle_api.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie_detail.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.movieId});
  final int movieId;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetail> movieDetails;
  late Future<Credits> movieCasts;
  @override
  void initState() {
    super.initState();
    movieDetails = controllerApi().fetchMovieDetail(widget.movieId);
    movieCasts = controllerApi().fetchCasts(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: FutureBuilder(
                future: movieDetails,
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(color: Colors.red),
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
                        style: const TextStyle(color: Colors.red),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                AppElevatedButton(text: "Get ticket"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
