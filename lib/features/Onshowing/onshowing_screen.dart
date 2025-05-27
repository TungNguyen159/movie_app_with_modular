import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/features/Onshowing/widgets/onshowing_list_item.dart';
import 'package:movie_app2/models/showtime.dart';
import 'package:movie_app2/service/showtime_service.dart';

class OnshowingScreen extends StatefulWidget {
  const OnshowingScreen({super.key});

  @override
  State<OnshowingScreen> createState() => _OnshowingScreenState();
}

class _OnshowingScreenState extends State<OnshowingScreen> {
  final showtimeService = ShowtimeService();
  DateTime? selectedDate;

  // Hàm mở DatePicker và cập nhật state
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Hàm tải lại dữ liệu (refresh)
  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
        : 'Chọn ngày';
    return Scaffold(
      appBar: AppBar(
        title: const TextHead(text: "Onshowing"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => _selectDate(context),
                  icon: const Icon(Icons.date_range),
                  label: const Text("Chọn ngày"),
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 8),
                if (selectedDate != null)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = null;
                      });
                    },
                    child: const Text("Reset"),
                  ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: FutureBuilder<List<Showtime>>(
                future: showtimeService.readshowtime(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Lỗi: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text("Không có suất chiếu nào."));
                  }

                  // Lọc những suất chiếu không có status là "closed"
                  final List<Showtime> filteredShowtimeList = snapshot.data!
                      .where((show) =>
                          show.status?.toLowerCase() != "canceled" &&
                          show.status?.toLowerCase() != "finished")
                      .toList();
                  final filteredShowtimes = selectedDate != null
                      ? filteredShowtimeList.where((showtime) {
                          final showtimeDate =
                              DateFormat('dd/MM/yyyy').format(showtime.date);
                          return showtimeDate == formattedDate;
                        }).toList()
                      : filteredShowtimeList;
                  if (filteredShowtimes.isEmpty) {
                    return const Center(
                        child: Text("Không có suất chiếu khả dụng."));
                  }
                  return OnshowingListItem(showtime: filteredShowtimes);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
