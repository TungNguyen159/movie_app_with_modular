import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TicketItem extends StatelessWidget {
  final String seatNumber;
  final String price;

  const TicketItem({
    super.key,
    required this.seatNumber,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          Center(
            child: Material(
              child: Container(
                color: const Color.fromARGB(255, 255, 235, 238),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      width: 140,
                      padding: const EdgeInsets.only(right: 10),
                      child: const Column(
                        children: [
                          Text(
                            "SEAT NUMBER",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 11),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "111", // Seat number is dynamic
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                   
                    Container(
                      padding: const EdgeInsets.only(left: 25),
                      height: 60,
                      width: 140,
                      child: Column(
                        children: [
                          const Text(
                            "PRICE",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 11),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            price, // Price is dynamic
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 255, 235, 238),
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 10,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: LayoutBuilder(
                      builder: (BuildContext context,
                          BoxConstraints constraints) {
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
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 10,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
