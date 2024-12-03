import 'dart:convert';

import 'package:movie_app/core/config/api_key.dart';
import 'package:movie_app/core/config/api_link.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_detail.dart';

class controllerApi {
  Future<List<Movies>> getPopularMovie() async {
    final response = await http.get(Uri.parse(keyLink.popular));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movies.fromJson(movie)).toList();
    } else {
      throw Exception('err');
    }
  }

  Future<List<Movies>> getListMovie() async {
    final response = await http.get(Uri.parse(keyLink.topRated));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movies.fromJson(movie)).toList();
    } else {
      throw Exception('err');
    }
  }

  Future<List<Movies>> getUpcomingMovie() async {
    final response = await http.get(Uri.parse(keyLink.upComing));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movies.fromJson(movie)).toList();
    } else {
      throw Exception('err');
    }
  }

  Future<List<Movies>> getNowPlayingMovie() async {
    final response = await http.get(Uri.parse(keyLink.nowPlaying));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movies.fromJson(movie)).toList();
    } else {
      throw Exception('err');
    }
  }

  Future<List<Movies>> searchMovie(String sMovie) async {
    final response = await http.get(Uri.parse(
        '${keyLink.baseUrl}3/search/movie?query=$sMovie&api_key=${Apikeys.api}'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((movie) => Movies.fromJson(movie)).toList();
    } else {
      throw Exception('err');
    }
  }

  Future<MovieDetail> fetchMovieDetail(int movieId) async {
    final response = await http.get(
        Uri.parse('${keyLink.baseUrl}3/movie/$movieId?api_key=${Apikeys.api}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieDetail.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<Credits> fetchCasts(int movieId) async {
    final response = await http.get(Uri.parse(
        '${keyLink.baseUrl}3/movie/$movieId/credits?api_key=${Apikeys.api}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Credits.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
