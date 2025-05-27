import 'package:flutter/material.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/features/Search/widgets/search_box.dart';
import 'package:movie_app2/features/manage/screen/qr_code.dart';
import 'package:movie_app2/features/manage/widget/booking_list_item.dart';
import 'package:movie_app2/service/booking_service.dart';

class ManageBooking extends StatefulWidget {
  const ManageBooking({super.key});

  @override
  State<ManageBooking> createState() => _ManageBookingState();
}

class _ManageBookingState extends State<ManageBooking> {
  final bookingService = BookingService();
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  // Lựa chọn status để lọc
  String selectedStatus = 'Tất cả'; // Mặc định là "Tất cả"

  // Hàm gọi khi người dùng gõ vào ô tìm kiếm, sử dụng debounce
  void _onSearchChanged(String value) {
    setState(() {});
  }

  // Hàm thay đổi status để lọc
  void _onStatusChanged(String? value) {
    setState(() {
      selectedStatus = value ?? 'Tất cả';
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách đặt vé")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchBox(
                    onChanged: _onSearchChanged,
                    focusNode: searchFocusNode,
                    controller: searchController,
                  ),
                ),
                Gap.smWidth,
                DropdownButton<String>(
                  value: selectedStatus,
                  items:
                      ['Tất cả', 'paid', 'pending', 'canceled'].map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: _onStatusChanged,
                ),
              ],
            ),
          ),
          Gap.sMHeight,
          Expanded(
            child: StreamBuilder(
              stream: bookingService.streambooking,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Lỗi: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Không có suất chiếu nào."));
                }
                final query = searchController.text.toLowerCase();
                final filteredBookings = snapshot.data!.where((booking) {
                  final bookingId = booking.bookingid?.toLowerCase() ?? "";
                  final bookingStatus = booking.status?.toLowerCase() ?? "";
                  final matchesId = bookingId.contains(query);
                  final matchesStatus = selectedStatus == 'Tất cả' ||
                      bookingStatus == selectedStatus.toLowerCase();
                  return matchesId && matchesStatus;
                }).toList();

                return BookingListItem(
                  bookingList: filteredBookings,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const QRScannerScreen()));
                  },
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
