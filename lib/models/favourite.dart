class Favourite {
  final String id;
  final String movieid;
  final String userid;

  Favourite({
    required this.id,
    required this.movieid,
    required this.userid,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) {
    return Favourite(
      id: json['id'],
      movieid: json['movie_id'],
      userid: json['user_id'],
    );
  }
}
