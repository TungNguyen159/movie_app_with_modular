class Reviews {
  final String? id;
  final String? userid;
  final String movieid;
  final int rate;
  final String content;
  final DateTime? createdat;

  Reviews({
    this.id,
    this.userid,
    required this.movieid,
    required this.rate,
    required this.content,
    this.createdat,
  });
  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
        id: json["id"],
        userid: json["user_id"],
        movieid: json["movie_id"],
        rate: json["rate"],
        content: json["content"],
        createdat: DateTime.parse(json["create_at"]));
  }
}
