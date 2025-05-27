import 'package:flutter/material.dart';

class Showtimestatus extends StatelessWidget {
  const Showtimestatus({
    super.key,
    required this.date,
    required this.starttime,
    required this.endtime,
  });

  final DateTime date;
  final String starttime;
  final String endtime;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Color statusColor;
    String statusText;
    // Chuyển đổi starttime và endtime thành DateTime có ngày thực tế
    DateTime start =
        DateTime.parse("${date.toIso8601String().split('T')[0]} $starttime");
    DateTime end =
        DateTime.parse("${date.toIso8601String().split('T')[0]} $endtime");

    if (now.isBefore(start)) {
      statusColor = Colors.green;
      statusText = "Có sẵn";
    } else if (now.isAfter(start) && now.isBefore(end)) {
      statusColor = Colors.orange;
      statusText = "Đang chiếu";
    } else {
      statusColor = Colors.grey;
      statusText = "Hoàn thành";
    }
    return Chip(
      label: Text(statusText, style: const TextStyle(color: Colors.white)),
      backgroundColor: statusColor,
    );
  }
}
