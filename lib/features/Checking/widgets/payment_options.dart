
import 'package:flutter/material.dart';

enum PaymentMethod { cash, card }

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key});

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  PaymentMethod? _payment = PaymentMethod.card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Mode',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: PaymentMethod.values.map((method) {
              return ListTile(
                leading: Radio<PaymentMethod>(
                  value: method,
                  groupValue: _payment,
                  activeColor: Colors.blue,
                  onChanged: (PaymentMethod? value) {
                    setState(() {
                      _payment = value;
                    });
                  },
                ),
                title: Text(
                  method == PaymentMethod.cash ? 'On Hand Cash' : 'Card',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
