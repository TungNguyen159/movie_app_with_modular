import 'package:flutter/material.dart';
import 'package:movie_app2/models/payment.dart';

class Vnpaylistitem extends StatelessWidget {
  const Vnpaylistitem({
    super.key,
    required this.data,
  });

  final Payment data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Thông tin thanh toán",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.info_outline, color: Colors.blue),
                title: const Text("Nội dung giao dịch"),
                subtitle: Text(data.vnporderInfo),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.numbers, color: Colors.green),
                title: const Text("Mã giao dịch"),
                subtitle: Text(data.vnptransactionNo),
              ),
              const Divider(),
              ListTile(
                leading:
                    const Icon(Icons.calendar_today, color: Colors.deepPurple),
                title: const Text("Ngày giao dịch"),
                subtitle: Text(data.vnptransactiondate),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
