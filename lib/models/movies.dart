import 'package:movie_app2/models/genres.dart';

class Movies {
  final String? movieid;
  final String? genreid;
  final String title;
  final int average;
  final int duration;
  final String posterurl;
  final String description;
  final String releasedate;
  final String? createat;
  final Genres? genres;

  Movies(
      {this.movieid,
      this.genreid,
      required this.title,
      required this.average,
      required this.duration,
      required this.posterurl,
      required this.description,
      required this.releasedate,
      this.createat,
      this.genres});

  factory Movies.fromJson(Map<String, dynamic> json) {
    return Movies(
      movieid: json['movieid'].toString(),
      genreid: json['genres_id'].toString(),
      title: json['title'],
      average: json['average'],
      duration: json['duration'],
      posterurl: json['poster_url'],
      description: json['description'],
      releasedate: json['release_date'],
      createat: json['created_at'],
      genres: json["genres"] != null ? Genres.fromJson(json['genres']) : null,
    );
  }
}
