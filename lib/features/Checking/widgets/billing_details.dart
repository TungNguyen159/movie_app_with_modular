import 'package:flutter/material.dart';

class BillingDetails extends StatelessWidget {
  const BillingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Billing Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          _BillingSummary(),
          const Divider(color: Colors.black, thickness: 0.8),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Total - Rs.1000',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
class _BillingSummary extends StatelessWidget {
  const _BillingSummary();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            _SummaryLabel(width: 40, text: 'Qty'),
            _SummaryLabel(width: 10, text: 'Ticket Type'),
            Spacer(),
            _SummaryLabel(width: 0, text: 'Price'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            _SummaryData(width: 40, text: '4'),
            _SummaryData(width: 10, text: 'Normal Seat'),
            Spacer(),
            _SummaryData(width: 0, text: '500'),
          ],
        ),
      ],
    );
  }
}

class _SummaryLabel extends StatelessWidget {
  final double width;
  final String text;

  const _SummaryLabel({required this.width, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: width),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _SummaryData extends StatelessWidget {
  final double width;
  final String text;

  const _SummaryData({required this.width, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: width),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
