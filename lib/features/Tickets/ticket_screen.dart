import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/Widgets/app_button.dart';
import 'package:movie_app/config/api_handle.dart';
import 'package:movie_app/features/Tickets/widgets/date_selector.dart';
import 'package:movie_app/features/Tickets/widgets/seat_selector.dart';
import 'package:movie_app/features/Tickets/widgets/time_selector.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key, required this.movieId});
  final int movieId;

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  late Future<String> movietitle;

  @override
  void initState() {
    super.initState();
    movietitle = ControllerApi().getitle(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // Tách AppBar thành hàm riêng
      body: Column(
        children: [
          const DateSelector(),
          const TimeSelector(),
          const Expanded(child: SeatSelector()),
          _buildNextButton(context),
        ],
      ),
    );
  }

  // Hàm xây dựng AppBar
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Modular.to.pop();
        },
      ),
      title: FutureBuilder<String>(
        future: movietitle,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..."); // Hiển thị khi đang tải
          } else if (snapshot.hasError) {
            return const Text("Error loading title"); // Lỗi
          } else {
            return Text(snapshot.data ?? "No Title", // In ra title
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
          }
        },
      ),
    );
  }

  // Hàm xây dựng nút Next
  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: AppButton(
          text: "Next",
        
          onPressed: () {
            Modular.to.pushNamed(
              '/main/detail/ticket/seat/${widget.movieId}',
            );
          },
        ),
      ),
    );
  }
}
