import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/models/booking.dart';
import 'package:movie_app2/service/user_service.dart';

class BookingListItem extends StatelessWidget {
  const BookingListItem({
    super.key,
    required this.bookingList,
  });

  final List<Booking> bookingList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookingList.length,
      itemBuilder: (context, index) {
        final booking = bookingList[index];
        final datetext =
            DateFormat('dd/MM/yyyy').format(DateTime.parse(booking.time!));
        return GestureDetector(
          onTap: () {
            Modular.to.pushNamed("/manage/bookdetail", arguments: {
              "bookingid": booking.bookingid,
            });
          },
          child: FutureBuilder(
            future: UserService().getUserbyid(booking.userid!),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const ListTile(
                  title: Text("Lỗi tải user "),
                  subtitle: Text("Không thể lấy dữ liệu user."),
                );
              }

              final user = snapshot.data!;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Id: ${booking.bookingid}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "User: ${user.name}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Email: ${user.email}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Tổng tiền: ${booking.totalprice} VNĐ",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Ngày đặt: $datetext",
                              style: const TextStyle(
                                fontSize: 12, // Giảm kích thước chữ
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Chip(
                                label: Text(
                                  booking.status!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                backgroundColor: booking.status! == "paid"
                                    ? Colors.green
                                    : booking.status! == "canceled"
                                        ? Colors.grey
                                        : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
