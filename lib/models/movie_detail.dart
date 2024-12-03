import 'package:movie_app/models/movie.dart';

class MovieDetail extends Movies {
  final int budget;
  final List<Genres> genres;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;

  MovieDetail({
    required super.adult,
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.posterPath,
    required super.popularity,
    required super.releaseDate,
    required super.title,
    required super.video,
    required super.voteAverage,
    required super.voteCount,
    required this.budget,
    required this.genres,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
  });
  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      adult: json['adult'] ?? false,
      budget: json['budget'] ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((item) => Genres.fromJson(item))
              .toList() ??
          [],
      id: json['id'] ?? 0,
      originalTitle: json['original_title'] ?? 'Unknown Title',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? 'Unknown',
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
              ?.map((item) => SpokenLanguage.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? 'Unknown',
      tagline: json['tagline'],
      title: json['title'] ?? 'Unknown',
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      backdropPath: json['backdrop_path'] ?? '',
      genreIds: (json["genre_ids"] as List<dynamic>?)
              ?.map((x) => x as int)
              .toList() ??
          [],
      originalLanguage: json["original_language"] ?? 'Unknown',
      video: json["video"] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'budget': budget,
      'genres': genres.map((genre) => genre.toJson()).toList(),
      'id': id,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'revenue': revenue,
      'runtime': runtime,
      'original_language': originalLanguage,
      'spoken_languages': spokenLanguages.map((lang) => lang.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'genre_ids': genreIds,
      'backdrop_path': backdropPath,
    };
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SpokenLanguage {
  final String iso6391;
  final String name;

  SpokenLanguage({required this.iso6391, required this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      iso6391: json['iso_639_1'] ?? '',
      name: json['name'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_639_1': iso6391,
      'name': name,
    };
  }
}
