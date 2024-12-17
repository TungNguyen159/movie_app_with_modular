import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';

class SeatSelectionWidget extends StatelessWidget {
  final int rows;
  final int columns;
  final List<Seat> selectedSeats; // Danh sách các ghế đã chọn

  const SeatSelectionWidget({
    Key? key,
    required this.rows,
    required this.columns,
    required this.selectedSeats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns, // Số cột
        childAspectRatio: 1, // Tỉ lệ ô vuông
      ),
      itemCount: rows * columns, // Tổng số ghế
      itemBuilder: (context, index) {
        final seatNumber = index + 1;
        final isSelected = selectedSeats.any((seat) => seat.id == seatNumber);

        return SeatWidget(
          seatNumber: seatNumber,
          isSelected: isSelected,
        );
      },
    );
  }
}

// Widget đại diện cho 1 ghế
class SeatWidget extends StatelessWidget {
  final int seatNumber;
  final bool isSelected;

  const SeatWidget({
    Key? key,
    required this.seatNumber,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color:
            isSelected ? Colors.red : Colors.grey[300], // Đổi màu khi đã chọn
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Center(
        child: Text(
          seatNumber.toString(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Model cho ghế ngồi
class Seat {
  final int id; // Mã ghế
  Seat({required this.id});
}


class SeatSelector extends StatelessWidget {
  const SeatSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Seat> selectedSeats = [
      Seat(id: 3),
      Seat(id: 7),
      Seat(id: 12),
      Seat(id: 15),
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Phần tiêu đề cố định
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextHead(text: 
              "Seat Selection",
             
            ),
          ),
          const SizedBox(height: 10),

          // Phần cuộn
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("screen.png"),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SeatSelectionWidget(
                      rows: 8, // Số hàng
                      columns: 7, // Số cột
                      selectedSeats: selectedSeats, // Danh sách ghế đã chọn
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
