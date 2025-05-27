import 'package:movie_app2/models/genres.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GenresService {
  final supabase = Supabase.instance.client;
  // insert genres
  Future<void> insertGenres(Genres genres) async {
    await supabase.from("genres").insert({
      "name": genres.name,
    });
  }

  Future<List<Genres>> getGenres() async {
    final response = await supabase.from("genres").select();

    return response.map((e) => Genres.fromJson(e)).toList();
  }

  // check genre in movie
  Future<bool> checkgenre(Genres genre) async {
    final response =
        await supabase.from("movies").select().eq("genres_id", genre.id!);
    return response.isNotEmpty;
  }

  // realtime genres
  final genresstream = Supabase.instance.client
      .from("genres")
      .stream(primaryKey: ['id']).map(
          (data) => data.map((e) => Genres.fromJson(e)).toList());

  // update genres
  Future<void> updateGenres(Genres genres) async {
    await supabase
        .from("genres")
        .update({"name": genres.name}).eq("id", genres.id!);
  }

  //delete genres
  Future<void> deleteGenres(Genres genres) async {
    await supabase.from("genres").delete().eq("id", genres.id!);
  }
}
