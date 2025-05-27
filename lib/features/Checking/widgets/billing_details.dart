import 'package:flutter/material.dart';
import 'package:movie_app2/models/seat.dart';
import 'package:intl/intl.dart'; // Thư viện để format tiền

class BillingDetails extends StatelessWidget {
  BillingDetails({super.key, required this.selectedSeats});

  final List<Seat> selectedSeats;

  final currencyFormatter = NumberFormat("#,###", "vi_VN"); // Format tiền

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chi tiết đặt chỗ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),

            // Header
            const Row(
              children: [
                Expanded(child: _SummaryLabel(text: 'Số ghế')),
                Expanded(child: _SummaryLabel(text: 'Loại')),
                Expanded(child: _SummaryLabel(text: 'Giá')),
              ],
            ),
            const Divider(color: Colors.black),

            // Danh sách ghế đã chọn
            ...selectedSeats.map((seat) => Row(
                  children: [
                    Expanded(child: _SummaryData(text: seat.seatnumber!)),
                    Expanded(
                        child: _SummaryData(
                            text: seat.type == 'vip' ? 'VIP' : 'Thường')),
                    Expanded(
                      child: _SummaryData(
                        text: '${currencyFormatter.format(seat.price)} VNĐ',
                      ),
                    ),
                  ],
                )),

            const Divider(color: Colors.black, thickness: 1),
          ],
        ),
      ),
    );
  }
}

// Component Label tiêu đề
class _SummaryLabel extends StatelessWidget {
  final String text;
  const _SummaryLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}

// Component hiển thị dữ liệu
class _SummaryData extends StatelessWidget {
  final String text;
  const _SummaryData({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
    );
  }
}
