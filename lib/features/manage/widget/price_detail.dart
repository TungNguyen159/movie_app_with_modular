import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceDetail extends StatelessWidget {
  const PriceDetail({
    super.key,
    required this.totalPrice,
    required this.taxAmount,
    this.code,
    required this.discountAmount,
    required this.finalPrice,
  });
  final int totalPrice;
  final int taxAmount;
  final int discountAmount;
  final int finalPrice;
  final String? code;
  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat("#,###", "vi_VN");
    return Container(
      padding: const EdgeInsets.all(8),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tổng: ${currencyFormatter.format(totalPrice)} VNĐ",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            "Thuế (10%): ${currencyFormatter.format(taxAmount)} VNĐ",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          if (discountAmount > 0)
            Text(
              "Giảm giá($code): -${currencyFormatter.format(discountAmount)} VNĐ",
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
          const Divider(color: Colors.black, thickness: 1),
          Text(
            "Tổng tiền: ${currencyFormatter.format(finalPrice)} VNĐ",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
