import 'package:movie_app2/models/showtime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShowtimeService {
  final supabase = Supabase.instance.client;
  int pagesize = 20;
  int page = 0;
  //insert showtime
  Future<void> insertShowtime(Showtime showtimes) async {
    await supabase.from('showtimes').insert({
      'movie_id': showtimes.movieid,
      'hall_id': showtimes.hallid,
      'start_time': showtimes.starttime,
      'end_time': showtimes.endtime,
      'date': showtimes.date.toIso8601String(),
      'price': showtimes.price,
      'status': "available",
    });
  }

  // read showtime
  Future<List<Showtime>> readshowtime() async {
    final response = await supabase
        .from("showtimes")
        .select()
        .order("date", ascending: false);

    return response.map((e) => Showtime.fromJson(e)).toList();
  }

  //read showtime by id realtime
  final streamShowtime = Supabase.instance.client
      .from('showtimes')
      .stream(
        primaryKey: ['id'],
      )
      .order("date", ascending: false)
      .map((data) => data.map((e) => Showtime.fromJson(e)).toList());
  // read showtime by movieid
  Future<List<Showtime>> getShowtimeMovieid(String movieId) async {
    final response = await supabase
        .from('showtimes')
        .select('*, halls(*)')
        .eq('movie_id', movieId);
    return response.map((showtime) => Showtime.fromJson(showtime)).toList();
  }

  // fetch showtime id
  Future<Showtime> fetchbyshowtimeid(String showtimeid) async {
    final response = await supabase
        .from('showtimes')
        .select("*,movies(*),halls(*)")
        .eq('id', showtimeid)
        .single();
    return Showtime.fromJson(response);
  }

  // check time
  Future<bool> isShowtimeAvailable(
      String hallId, String startTime, String endTime, DateTime date) async {
    final response = await supabase
        .from('showtimes')
        .select()
        .eq('hall_id', hallId)
        .eq('date', date)
        .gte('end_time', startTime)
        .lte('start_time', endTime);
    return response.isEmpty; // Nếu không có suất chiếu trùng thì có thể thêm
  }

  // update showtime
  Future<void> updateShowtime(Showtime showtimes) async {
    await supabase
        .from('showtimes')
        .update({
          'movie_id': showtimes.movieid,
          'hall_id': showtimes.hallid,
          'start_time': showtimes.starttime,
          'end_time': showtimes.endtime,
          'date': showtimes.date.toIso8601String(),
          'price': showtimes.price,
          'status': "available",
        })
        .eq('id', showtimes.showtimeid!)
        .select();
  }

  // delete showtime
  Future<void> deleteShowtime(Showtime showtime) async {
    try {
      final result = await supabase
          .from('showtimes')
          .delete()
          .eq('id', showtime.showtimeid!)
          .select();

      if (result.isEmpty) {
        throw Exception('Permission denied');
      }
    } catch (e) {
      rethrow; // Ném lỗi lại để xử lý ở UI
    }
  }

  // update status
  Future<void> updateStatusST(String newStatus, Showtime showtime) async {
    await supabase
        .from('showtimes')
        .update({
          'status': newStatus,
        })
        .eq('id', showtime.showtimeid!)
        .select();
  }

  // update status finished
  Future<void> updateStatuss() async {
    final today = DateTime.now();
    final todayOnlyDate = DateTime(today.year, today.month, today.day);
    await supabase
        .from('showtimes')
        .update({'status': 'finished'})
        .lt('date', todayOnlyDate.toIso8601String())
        .eq('status', 'available');
  }
}
