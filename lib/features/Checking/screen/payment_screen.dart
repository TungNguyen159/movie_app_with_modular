import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app/Widgets/app_button.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/features/Checking/screen/Confirmation_screen.dart';
import 'package:movie_app/features/Checking/widgets/billing_details.dart';
import 'package:movie_app/features/Checking/widgets/payment_options.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Back icon and title
              const _BackIconRow(),

              const SizedBox(height: 20),

              // Billing Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: BillingDetails(),
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
                padding: EdgeInsets.all(20),
                child: AppButton(
                  text: 'Pay',
                 
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ConfirmationScreen()));
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

class _BackIconRow extends StatelessWidget {
  const _BackIconRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_sharp, size: 26),
          onPressed: () => Modular.to.pop(),
        ),
        const Spacer(),
        const TextHead(text: 'Payment Options'),
        const Spacer(flex: 3),
      ],
    );
  }
}
