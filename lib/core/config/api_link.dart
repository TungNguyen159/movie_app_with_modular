import 'package:movie_app/core/config/api_key.dart';

class keyLink {
  static const String baseUrl = 'https://api.themoviedb.org/';
  static const String imagePath = 'https://image.tmdb.org/t/p/w400/';
  static const String popular = '${baseUrl}3/movie/popular?api_key=${Apikeys.api}';
  static const String topRated = '${baseUrl}3/movie/top_rated?api_key=${Apikeys.api}';
  static const String genres = '${baseUrl}3/genre/movie/list?api_key=${Apikeys.api}';
  static const String upComing = '${baseUrl}3/movie/upcoming?api_key=${Apikeys.api}';
  static const String nowPlaying = '${baseUrl}3/movie/now_playing?api_key=${Apikeys.api}';
 

}