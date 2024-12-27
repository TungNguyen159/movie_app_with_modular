import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/Widgets/app_button.dart';
import 'package:movie_app/Widgets/back_button.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/features/Checking/screen/Confirmation_screen.dart';
import 'package:movie_app/features/Checking/widgets/billing_details.dart';
import 'package:movie_app/features/Checking/widgets/payment_options.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHead(text: "Payment Options"),
        leading: BackBind(
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              // Billing Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const BillingDetails(),
                ),
              ),

              const SizedBox(height: 20),

              // Payment Options
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const PaymentOptions(),
                  ),
                ),
              ),

              // Pay Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: AppButton(
                  text: 'Pay',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const ConfirmationScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

