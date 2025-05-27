import 'package:movie_app2/models/showtime.dart';
import 'package:movie_app2/models/user.dart';

class Booking {
  final String? bookingid;
  final String? userid;
  final String showtimeid;
  final String? status;
  final String? time;
  final int totalprice;
  final String? couponid;
  final bool? isreviewed;
  final Users? user;
  final Showtime? showtime;

  Booking({
    this.bookingid,
    this.userid,
    required this.showtimeid,
    this.status,
    this.time,
    required this.totalprice,
    this.couponid,
    this.isreviewed,
    this.user,
    this.showtime,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingid: json['id'],
      userid: json['user_id'],
      showtimeid: json['showtime_id'] ?? "null",
      status: json['status'],
      time: json['created_at'],
      totalprice: json['totalprice'],
      couponid: json['coupon_id'],
      isreviewed: json['is_reviewed'],

      user: json['user'] != null ? Users.fromJson(json['user']) : null,
      showtime: json['showtimes'] != null
          ? Showtime.fromJson(json['showtimes'])
          : null,
    );
  }
}
