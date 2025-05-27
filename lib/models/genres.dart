class Genres {
  final String? id;
  final String name;

  Genres({
    this.id,
    required this.name,
  });

  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(
      id: json["id"],
      name: json["name"],
    );
  }
}
