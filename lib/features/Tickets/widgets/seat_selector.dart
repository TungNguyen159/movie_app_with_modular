import 'package:flutter/material.dart';
import 'package:movie_app2/models/seat.dart';
import 'package:movie_app2/service/hall_service.dart';
import 'package:movie_app2/service/seat_service.dart';
import 'package:movie_app2/service/showtime_service.dart';

class SeatBookingScreen extends StatefulWidget {
  final Function(List<Seat>, int) onSeatSelected;
  final String showtimeId;
  final String hallid;
  const  SeatBookingScreen({
    super.key,
    required this.onSeatSelected,
    required this.showtimeId,
    required this.hallid,
  });

  @override
  State<SeatBookingScreen> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  final hallService = HallService();
  final showtimeService = ShowtimeService();
  final seatService = SeatService();
  List<Seat> seats = [];
  List<Seat> selectedSeats = [];
  int totalPrice = 0;
  int? columns;
  @override
  void initState() {
    super.initState();
    _fetchSeats();
  }

  // tạo danh sách ghế
  Future<void> _fetchSeats() async {
    final hallresponse = await hallService.fetchHallById(widget.hallid);
    final showtimeresponse =
        await showtimeService.fetchbyshowtimeid(widget.showtimeId);
    int rows = hallresponse.row;
    columns = hallresponse.column;
    int basePrices = showtimeresponse.price;
    List<Seat> fixedSeats = [];
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns!; col++) {
        String seatNumber = '${String.fromCharCode(65 + row)}${col + 1}';
        bool isNormal = row < (rows * 0.6);
        String type = isNormal ? 'normal' : 'vip';
        int price = isNormal ? basePrices : (basePrices * 1.5).toInt();

        fixedSeats.add(Seat(
          seatnumber: seatNumber,
          status: 'available',
          type: type,
          price: price,
        ));
      }
    }
    setState(() {
      seats = fixedSeats;
    });
  }

  void toggleSeat(Seat seat) {
    setState(() {
      if (seat.status == 'available') {
        if (selectedSeats.contains(seat)) {
          selectedSeats.remove(seat);
          seat.status = 'available';
          totalPrice -= seat.price!;
        } else {
          selectedSeats.add(seat);
          seat.status = 'booked';
          totalPrice += seat.price!;
        }
      } else if (seat.status == 'booked') {
        seat.status = 'available';
        selectedSeats.remove(seat);
        totalPrice -= seat.price!;
      }

      widget.onSeatSelected(selectedSeats, totalPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Sơ đồ ghế",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Image.asset("assets/screen.png"),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: columns != null
                    ? StreamBuilder<List<Seat>>(
                        stream:
                            seatService.getseatbyshowtime(widget.showtimeId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final bookedSeats = snapshot.data!;
                          final updatedSeats = seats;
                          for (var bookedSeat in bookedSeats) {
                            String seatNumber = bookedSeat.seatnumber!;
                            int seatIndex = updatedSeats.indexWhere(
                                (seat) => seat.seatnumber == seatNumber);
                            if (seatIndex != -1) {
                              updatedSeats[seatIndex].status =
                                  'unavailable'; // Ghế đã được đặt trước
                            }
                          }
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  columns!, // an toàn vì đã kiểm tra ở trên
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemCount: updatedSeats.length,
                            itemBuilder: (context, index) {
                              final seat = updatedSeats[index];
                              return _buildSeatWidget(seat);
                            },
                          );
                        })
                    : const Center(child: CircularProgressIndicator())),
          ),
          const SizedBox(height: 16),
          Text(
            "Tổng tiền: $totalPrice vnđ",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatWidget(Seat seat) {
    Color seatColor;
    if (seat.status == 'unavailable') {
      seatColor = Colors.grey;
    } else if (selectedSeats.contains(seat)) {
      seatColor = Colors.red;
    } else {
      seatColor = seat.type == 'vip' ? Colors.amber : Colors.green;
    }

    return GestureDetector(
      onTap: seat.status != 'unavailable' ? () => toggleSeat(seat) : null,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          seat.seatnumber!,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
