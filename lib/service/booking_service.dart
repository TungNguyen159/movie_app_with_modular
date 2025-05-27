import 'package:intl/intl.dart';
import 'package:movie_app2/models/booking.dart';
import 'package:movie_app2/models/month_stat.dart';
import 'package:movie_app2/models/showtime.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class BookingService {
  final supabase = Supabase.instance.client;
  // insert
  Future<String?> insertBooking(Booking booking) async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;
    final response = await supabase.from("bookings").insert({
      "user_id": user.id,
      "showtime_id": booking.showtimeid,
      "totalprice": booking.totalprice,
      "coupon_id": booking.couponid,
      "status": "pending",
    }).select();

    if (response.isNotEmpty) {
      return response[0]['id'].toString(); // Trả về bookingId
    }
    return null;
  }

  // insert vnp
  Future<String?> insertBookingvnp(Booking booking) async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    final response = await supabase.from("bookings").insert({
      "user_id": user.id,
      "showtime_id": booking.showtimeid,
      "totalprice": booking.totalprice,
      "coupon_id": booking.couponid,
      "status": "paid",
    }).select();

    if (response.isNotEmpty) {
      return response[0]['id'].toString(); // Trả về bookingId
    }
    return null;
  }

  //read booking
  final streambooking = Supabase.instance.client
      .from("bookings")
      .stream(
        primaryKey: ['id'],
      )
      .order("created_at", ascending: false)
      .map((data) => data.map((e) => Booking.fromJson(e)).toList());

  //get booking by id
  Future<Booking?> getbookingbyid(String bookingid) async {
    final response = await supabase
        .from("bookings")
        .select("*,showtimes(*)")
        .eq("id", bookingid)
        .maybeSingle();
    if (response == null || response.isEmpty) return null;
    return Booking.fromJson(response);
  }

  // update booking status
  Future<void> updatestatus(String bookingid) async {
    await supabase
        .from("bookings")
        .update({'status': "paid"}).eq('id', bookingid);
  }

  // update booking status cancel
  Future<void> updatestatusCancel(String bookingid) async {
    await supabase
        .from("bookings")
        .update({'status': "canceled"}).eq('id', bookingid);
  }

  // update booking reviewed
  Future<void> updatereviewed(String bookingid) async {
    await supabase
        .from("bookings")
        .update({'is_reviewed': "true"}).eq('id', bookingid);
  }

  // read booking by userid
  Stream<List<Booking>?> get streambookings {
    final currentUserId = supabase.auth.currentUser?.id;
    if (currentUserId == null) {
      return Stream.value(null);
    }
    return supabase
        .from('bookings')
        .stream(primaryKey: ["id"])
        .eq('user_id', currentUserId)
        .order("created_at", ascending: false)
        .map((data) => data.map((e) => Booking.fromJson(e)).toList());
  }

  Future<bool> checkbookingstatus(Showtime showtime) async {
    final response = await supabase
        .from("bookings")
        .select()
        .eq("showtime_id", showtime.showtimeid!)
        .not('status', "eq", 'canceled');
    return response.isNotEmpty;
  }

  // read stat
  Future<List<MonthlyRevenueStats>> fetchMonthlyRevenue() async {
    // Lấy toàn bộ dữ liệu booking đã thanh toán
    final response =
        await supabase.from('bookings').select('*').eq('status', 'paid');

    // Xử lý dữ liệu bằng Dart
    List<dynamic> bookingsData = response;

    // Nhóm dữ liệu theo tháng
    Map<String, List<dynamic>> monthlyBookings = {};

    for (var booking in bookingsData) {
      // Chuyển đổi ngày sang định dạng yyyy-MM
      DateTime bookingDate = DateTime.parse(booking['created_at']);
      String monthKey = DateFormat('yyyy-MM').format(bookingDate);

      // Nhóm booking theo tháng
      if (!monthlyBookings.containsKey(monthKey)) {
        monthlyBookings[monthKey] = [];
      }
      monthlyBookings[monthKey]!.add(booking);
    }

    // Tính toán thống kê cho từng tháng
    List<MonthlyRevenueStats> monthlyStats = [];

    monthlyBookings.forEach((month, bookings) {
      // Tính tổng doanh thu
      int totalRevenue = bookings.fold(
        0,
        (sum, booking) =>
            sum +
            ((booking['totalprice'] is num)
                ? (booking['totalprice'] as num).round()
                : 0),
      );
      // Đếm số lượng booking
      int bookingCount = bookings.length;
      // Thêm vào danh sách thống kê
      monthlyStats.add(MonthlyRevenueStats(
        month: month,
        totalRevenue: totalRevenue,
        bookingCount: bookingCount,
      ));
    });

    // Sắp xếp theo thứ tự tháng
    monthlyStats.sort((a, b) => a.month.compareTo(b.month));
    return monthlyStats;
  }

  Future<List<Map<String, dynamic>>> getStatisticmovie() async {
    final response = await supabase
        .from("bookings")
        .select("*,showtimes(movie_id)")
        .eq("status", "paid");

    Map<String, Map<String, dynamic>> revenueMap = {};

    for (var row in response) {
      final movieId = row["showtimes"]["movie_id"];
      final totalPrice = row["totalprice"] ?? 0;

      if (revenueMap.containsKey(movieId)) {
        revenueMap[movieId]!["total_revenue"] += totalPrice;
      } else {
        revenueMap[movieId] = {
          "movieid": movieId,
          "total_revenue": totalPrice,
        };
      }
    }

    return revenueMap.values.toList();
  }

    Future<Map<String, int>> getBookingStatusCount() async {
    final response = await supabase.from('bookings').select('status');

    // Tạo một Map để lưu trữ số lượng vé theo từng trạng thái
    Map<String, int> statusCount = {};
    for (var row in response) {
      String status = row['status'];
      // Nếu trạng thái đã tồn tại trong map, tăng số lượng lên 1, nếu chưa thì tạo mới với giá trị 1
      if (statusCount.containsKey(status)) {
        statusCount[status] = statusCount[status]! + 1;
      } else {
        statusCount[status] = 1;
      }
    }
    return statusCount;
  }
}
