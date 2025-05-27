import 'dart:io';

import 'package:movie_app2/models/movies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MovieService {
  final supabase = Supabase.instance.client;

  final streamMovies = Supabase.instance.client
      .from('movies')
      .stream(primaryKey: ['movieid'])
      .order("created_at", ascending: false)
      .map((data) => data.map((e) => Movies.fromJson(e)).toList());
  //insert movie
  Future<void> insertmovie(Movies movie) async {
    await supabase.from('movies').insert({
      'title': movie.title,
      'genres_id': movie.genreid,
      'description': movie.description,
      'duration': movie.duration,
      'average': movie.average,
      'poster_url': movie.posterurl,
      'release_date': movie.releasedate,
    });
  }
  //read movie all
  Future<List<Movies>> getmovie() async {
    final response = await supabase
        .from('movies')
        .select()
        .order("created_at", ascending: false);
    return response.map((movie) => Movies.fromJson(movie)).toList();
  }

  // read movie page
  Future<List<Movies>> getmovies({int page = 1, int limit = 9}) async {
    final response = await supabase
        .from('movies')
        .select()
        .range((page - 1) * limit, (page * limit) - 1);

    return (response as List).map((json) => Movies.fromJson(json)).toList();
  }

  //read moviedetail
  Future<Movies> getmovieid(String? movieId) async {
    final response = await supabase
        .from('movies')
        .select('*,genres(name)')
        .eq('movieid', movieId!)
        .single();

    return Movies.fromJson(response);
  }

  //get movie by genre
  Future<List<Movies>> getmoviebygen(String genreid) async {
    final response =
        await supabase.from('movies').select().eq('genres_id', genreid);
    return response.map((e) => Movies.fromJson(e)).toList();
  }

  //insert image to bucket
  Future<String?> uploadImage(File imageFile) async {
    final imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final response =
        await supabase.storage.from('image').upload(imageName, imageFile);
    if (response.isNotEmpty) {
      return supabase.storage.from('image').getPublicUrl(imageName);
    } else {
      return null;
    }
  }

  // check genre in movie
  Future<bool> checkgenre(String genreid) async {
    final response =
        await supabase.from("movies").select().eq("genres_id", genreid);
    return response.isNotEmpty;
  }

  // search movie
  Future<List<Movies>> searchMovie(String query) async {
    final response =
        await supabase.from('movies').select().ilike('title', '%$query%');
    return response.map((movie) => Movies.fromJson(movie)).toList();
  }

  //update
  Future<void> updateMovie(Movies movie) async {
    await supabase.from('movies').update({
      'genres_id': movie.genreid,
      'title': movie.title,
      'description': movie.description,
      'duration': movie.duration,
      'average': movie.average,
      'poster_url': movie.posterurl,
      'release_date': movie.releasedate,
    }).eq('movieid', movie.movieid!);
  }

  //delete
  Future<void> deleteMovie(Movies movie) async {
    await supabase.from('movies').delete().eq('movieid', movie.movieid!);
  }
}
