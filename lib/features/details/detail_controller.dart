import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/config/api_handle.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_detail.dart';

class DetailController extends Disposable {
  final ControllerApi controllerApis;
  final int movieId;
  late final Future<MovieDetail> movieDetails;
  late final Future<Credits> movieCasts;
  late final Future<List<Movies>> recommendMovies;
  //late final Future<List<dynamic>> movieVideos;

  DetailController(this.controllerApis, this.movieId) {
    movieDetails = controllerApis.fetchMovieDetail(movieId);
    movieCasts = controllerApis.fetchCasts(movieId);
    recommendMovies = controllerApis.recommendMovie(movieId);
    // movieVideos = controllerApis.fetchVideos(movieId);
  }
  @override
  void dispose() {}
}
