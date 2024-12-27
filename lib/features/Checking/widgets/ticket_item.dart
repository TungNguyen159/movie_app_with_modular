import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/gap.dart';

class TicketItem extends StatelessWidget {
  final String seatNumber;
  final String price;

  const TicketItem({
    super.key,
    required this.seatNumber, // Bắt buộc giá trị không null
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Material(
          color: const Color.fromARGB(255, 252, 205, 212), // Background color
          child: Container(
            padding: const EdgeInsets.all(Gap.sM),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Seat Number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "SEAT NUMBER",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                        color: Colors.black,
                      ),
                    ),
                    Gap.xsHeight,
                    Text(
                      seatNumber, // Giá trị dynamic
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "PRICE",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 11,
                        color: Colors.black,
                      ),
                    ),
                    Gap.xsHeight,
                    Text(
                      price, // Giá trị dynamic
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Divider Line
        Container(
          color: const Color.fromARGB(255, 252, 205, 212),
          padding: const EdgeInsets.symmetric(vertical: Gap.sm),
          child: Row(
            children: [
              // Start Rounded Line
              SizedBox(
                height: 20,
                width: 10,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              // Dotted Line
              Expanded(
                child: LayoutBuilder(
                  builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      direction: Axis.horizontal,
                      children: List.generate(
                        (constraints.constrainWidth() / 15).floor(),
                        (index) => const SizedBox(
                          width: 5,
                          height: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // End Rounded Line
              SizedBox(
                height: 20,
                width: 10,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
