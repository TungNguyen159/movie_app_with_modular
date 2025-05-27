import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/features/manage/screen/add_showtime.dart';
import 'package:movie_app2/features/manage/widget/showtime_list_item.dart';
import 'package:movie_app2/models/showtime.dart';
import 'package:movie_app2/service/showtime_service.dart';

class ManageShowtime extends StatefulWidget {
  const ManageShowtime({super.key});

  @override
  State<ManageShowtime> createState() => _ManageShowtimeState();
}

class _ManageShowtimeState extends State<ManageShowtime> {
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

  @override
  Widget build(BuildContext context) {
    final formattedDate = selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(selectedDate!)
        : 'Chọn ngày';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Showtime"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
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
                        IconButton(
                            onPressed: () {
                              showtimeService.updateStatuss();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Cập nhật thành công")),
                              );
                            },
                            icon: const Icon(Icons.update)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<List<Showtime>>(
                      stream: showtimeService.streamShowtime,
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text("Lỗi: ${snapshot.error}"));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text("Không có suất chiếu nào."));
                        }

                        final List<Showtime> showtimeList = snapshot.data!;
                        // Lọc danh sách showtimes nếu có ngày đã chọn
                        final filteredShowtimes = selectedDate != null
                            ? showtimeList.where((showtime) {
                                final showtimeDate = DateFormat('dd/MM/yyyy')
                                    .format(showtime.date);
                                return showtimeDate == formattedDate;
                              }).toList()
                            : showtimeList;

                        return ShowtimeListItem(showtime: filteredShowtimes);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => const AddShowtimeScreen()),
                    );
                  },
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
