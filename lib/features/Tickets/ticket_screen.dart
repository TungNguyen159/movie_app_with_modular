import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/Components/back_button.dart';
import 'package:movie_app2/Components/list_display.dart';
import 'package:movie_app2/Components/showtime_helper.dart';
import 'package:movie_app2/features/Tickets/widgets/seat_selector.dart';
import 'package:movie_app2/models/seat.dart';
import 'package:movie_app2/models/showtime.dart';
import 'package:movie_app2/service/showtime_service.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key, required this.movieId});
  final String movieId;

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  DateTime? selectedDate;
  String? selectedTime;
  String? selectedShowtimeId;
  String? selectedHallId;
  List<Seat> selectedSeat = [];
  late int? totalPrice;
  final showtimeService = ShowtimeService();
  late Future<List<Showtime>> showtimelist;
  @override
  void initState() {
    super.initState();
    showtimelist = showtimeService.getShowtimeMovieid(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // Tách AppBar thành hàm riêng
      body: Column(
        children: [
          ListDisplay(
            listFuture: showtimelist,
            builder: (snapshot) {
              final List<Showtime> filteredShowtimeList = snapshot
                  .where((show) =>
                      show.status?.toLowerCase() != "canceled" &&
                      ShowtimeHelper.getShowEndTime(show)
                          .isAfter(DateTime.now()))
                  .toList();

              // Lấy danh sách ngày không trùng nhau
              final uniqueDates =
                  filteredShowtimeList.map((s) => s.date).toSet().toList();

              return Column(
                children: [
                  // Hiển thị danh sách ngày
                  Wrap(
                    spacing: 8.0,
                    children: uniqueDates.map((date) {
                      final dateText = DateFormat('dd/MM/yyyy').format(date);
                      final isSelected = selectedDate == date;
                      return ChoiceChip(
                        label: Text(dateText),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedDate = selected ? date : null;
                            selectedTime =
                                null; // Reset suất chiếu khi đổi ngày
                            selectedShowtimeId = null;
                            selectedHallId = null;
                            selectedSeat.clear();
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 10),

                  // Hiển thị danh sách suất chiếu theo ngày đã chọn
                  if (selectedDate != null)
                    Wrap(
                      spacing: 8.0,
                      children: snapshot
                          .where((showtime) =>
                              showtime.date == selectedDate &&
                              showtime.status ==
                                  "available") // Lọc theo ngày đã chọn
                          .map((showtime) {
                        final isSelected = selectedTime == showtime.starttime;
                        return ChoiceChip(
                          label: Text(showtime.starttime),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                if (selectedShowtimeId != showtime.showtimeid) {
                                  selectedSeat.clear();
                                }
                                selectedShowtimeId = showtime.showtimeid;
                                selectedTime = showtime.starttime;
                                selectedHallId = showtime.hallid;
                              } else {
                                selectedShowtimeId = null;
                                selectedTime = null;
                                selectedHallId = null;
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                ],
              );
            },
          ),
          if (selectedShowtimeId != null && selectedHallId != null)
            Expanded(
              child: SeatBookingScreen(
                key: ValueKey(
                    selectedShowtimeId), // Đảm bảo widget rebuild khi showtime thay đổi
                onSeatSelected: (seats, totalPrice) {
                  setState(() {
                    selectedSeat = List.from(seats);
                    this.totalPrice = totalPrice;
                  });
                },
                showtimeId: selectedShowtimeId!,
                hallid: selectedHallId!,
              ),
            ),
          _buildNextButton(context),
        ],
      ),
    );
  }

  // Hàm xây dựng AppBar
  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        leading: BackBind(
          onPressed: () {
            Modular.to.pop();
          },
        ),
        title: const Text("Ticket"));
  }

  // Hàm xây dựng nút Next
  Widget _buildNextButton(BuildContext context) {
    final isDisabled = selectedTime == null || selectedSeat.isEmpty;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: GestureDetector(
          onTap: isDisabled
              ? null
              : () {
                  Modular.to.pushNamed(
                    '/main/detail/ticket/seat/${widget.movieId}',
                    arguments: {
                      "selectedSeat": selectedSeat,
                      "selectedShowtimeId": selectedShowtimeId,
                    },
                  );
                },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDisabled
                  ? Colors.grey // Màu xám nếu bị vô hiệu hóa
                  : Theme.of(context)
                      .colorScheme
                      .primary, // Màu xanh nếu hợp lệ
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                "Next",
                style: TextStyle(
                  color: isDisabled
                      ? Colors.black
                          .withOpacity(0.5) // Màu chữ khi bị vô hiệu hóa
                      : Colors.white, // Màu chữ khi hợp lệ
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
