import 'package:movie_app2/models/hall.dart';
import 'package:movie_app2/models/movies.dart';

class Showtime {
  final String? showtimeid;
  final String? movieid;
  final String? hallid;
  final String starttime;
  final String endtime;
  final int price;
  final DateTime date;
  final String? status;
  final Hall? halls;
  final Movies? movie;
  Showtime({
    this.showtimeid,
    required this.movieid,
    required this.hallid,
    required this.starttime,
    required this.endtime,
    required this.price,
    required this.date,
    this.status,
    this.halls,
    this.movie,
  });

  factory Showtime.fromJson(Map<String, dynamic> json) {
    return Showtime(
      showtimeid: json['id'].toString(),
      movieid: json['movie_id'] ?? 'no movieid',
      hallid: json['hall_id'] ?? 'no hallid',
      starttime: json['start_time'],
      endtime: json['end_time'],
      price: json['price'],
      date: DateTime.parse(json["date"]),
      status: json['status'],
      halls: json['halls'] != null ? Hall.fromJson(json['halls']) : null,
      movie: json['movies'] != null ? Movies.fromJson(json['movies']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'movie_id': movieid,
      'hall_id': hallid,
      'start_time': starttime,
      'end_time': endtime,
      'price': price,
      'date': date,
      'status': status,
    };
  }
  
}

