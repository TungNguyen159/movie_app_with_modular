import 'package:movie_app2/models/seat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SeatService {
  final supabase = Supabase.instance.client;
  // insert seat
  Future<void> insertseat(Seat seat) async {
    await supabase.from('seats').insert({
      'booking_id': seat.bookingid,
      'showtime_id': seat.showtimeId,
      'type': seat.type,
      'seatnumber': seat.seatnumber,
      'price': seat.price,
    });
  }

  Future<bool> isSeatBooked(
      String hallId, String showtimeId, String seatNumber) async {
    final response = await Supabase.instance.client
        .from('seats')
        .select()
        .eq('hallid', hallId)
        .eq('showtimeId', showtimeId)
        .eq('seatnumber', seatNumber)
        .maybeSingle();

    return response != null; // Nếu có dữ liệu, ghế đã được đặt
  }

  //read stream seat by showtime
  Stream<List<Seat>> getseatbyshowtime(String showtimeId) {
    return supabase
        .from('seats')
        .stream(primaryKey: ['id'])
        .eq('showtime_id', showtimeId)
        .map((data) => data.map((e) => Seat.fromJson(e)).toList());
  }

  // read seat
  Future<List<Seat>> getseat(String bookingid) async {
    final response = await supabase
        .from("seats")
        .select("*,showtimes(*)")
        .eq("booking_id", bookingid);
    return response.map((data) => Seat.fromJson(data)).toList();
  }

  //get seat by hall id
  Future<List<Seat>> getSeatsByHall(String hallId) async {
    final response =
        await supabase.from('seats').select('*').eq('hall_id', hallId);

    if (response.isEmpty) return [];

    return response.map((data) => Seat.fromJson(data)).toList();
  }

  // get seat by showtime id
  Future<List<Seat>> getSeatsByShowtime(String showtimeid) async {
    final response =
        await supabase.from('seats').select('*').eq('hall_id', showtimeid);

    if (response.isEmpty) return [];

    return response.map((data) => Seat.fromJson(data)).toList();
  }

  Future<void> deleteSeat(String bookingid) async {
    await supabase.from('seats').delete().eq('booking_id', bookingid);
  }
}
