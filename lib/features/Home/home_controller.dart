import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/config/api_handle.dart';
import 'package:movie_app/models/movie.dart';


class HomeController extends Disposable {
  final ControllerApi controllerApis;

  // Declare Future variables
  late final Future<List<Movies>> popularMovie;
  late final Future<List<Movies>> topRatedMovie;
  late final Future<List<Movies>> upComingMovie;
  late final Future<List<Movies>> nowPlaying;

  HomeController(this.controllerApis)  
      : popularMovie = controllerApis.getPopularMovie(),
        topRatedMovie = controllerApis.getTopRatedMovie(),
        upComingMovie = controllerApis.getUpComingMovie(),
        nowPlaying = controllerApis.getNowPlayingMovie();

  @override
  void dispose() {
    // Clean up if necessary
  }
}
