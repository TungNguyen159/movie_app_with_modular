import 'package:flutter/material.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/features/Yourbooking/widget/booking_list_item.dart';
import 'package:movie_app2/models/booking.dart';
import 'package:movie_app2/service/booking_service.dart';

enum BookingFilterMode { pending, all }

class BookedScreen extends StatefulWidget {
  const BookedScreen({super.key});

  @override
  State<BookedScreen> createState() => _BookedScreenState();
}

class _BookedScreenState extends State<BookedScreen> {
  final bookingService = BookingService();
  BookingFilterMode _filterMode = BookingFilterMode.pending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHead(text: "Your booking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // 2 nút filter
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _filterMode = BookingFilterMode.pending;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _filterMode == BookingFilterMode.pending
                          ? Colors.blue
                          : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Góc vuông hơn
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16), // Nút cao hơn
                    ),
                    child: const Text(
                      "Vé đang đặt",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _filterMode = BookingFilterMode.all;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _filterMode == BookingFilterMode.pending
                          ? Colors.grey
                          : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Lịch sử",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: StreamBuilder(
                stream: bookingService.streambookings,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Lỗi: ${snapshot.error}"));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Bạn chưa có vé nào!"));
                  }

                  final List<Booking> allBookings = snapshot.data!;
                  List<Booking> filteredBookings = [];

                  if (_filterMode == BookingFilterMode.pending) {
                    filteredBookings = allBookings
                        .where((booking) => booking.status == "pending")
                        .toList();
                  } else {
                    filteredBookings = allBookings
                        .where((booking) =>
                            booking.status == "canceled" ||
                            booking.status == "paid")
                        .toList();
                  }

                  if (filteredBookings.isEmpty) {
                    return const Center(child: Text("Chưa có vé đang đặt"));
                  }
                  return BookingListItem(booking: filteredBookings);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
