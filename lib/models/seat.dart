import 'package:movie_app2/models/showtime.dart';

class Seat {
  final String? seatid;
  final String? bookingid;
  final String? showtimeId;
  final String? seatnumber;
  final String type;
  final int? price;
  String? status;
  final Showtime? showtime;
  Seat({
    this.seatid,
    this.bookingid,
    this.showtimeId,
    this.seatnumber,
    this.price,
    this.status,
    required this.type,
    this.showtime,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      bookingid: json['booking_id'],
      showtimeId: json['showtime_id'],
      seatnumber: json['seatnumber'],
      status: json['status'],
      price: json['price'],
      type: json['type'],
      showtime: json['showtimes'] != null
          ? Showtime.fromJson(json['showtimes'])
          : null,
    );
  }
}
