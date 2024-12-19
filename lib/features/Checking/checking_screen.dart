import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/Checking/widgets/ticket_item.dart';

class SeatScreen extends StatefulWidget {
  final Map movie;
  const SeatScreen({super.key, required this.movie});

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          'Century Cinemax',
          style:
              textTheme.bodyLarge!.copyWith(fontSize: 22, color: Colors.white),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
        child: TextButton(
          child: const Text("pay"),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 300,
                  child: Image.asset("/no_image.png"),
                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: const Color.fromARGB(255, 255, 235, 238),
                ),
                Container(
                  color: const Color.fromARGB(255, 255, 235, 238),
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 10,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Flex(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                      const SizedBox(
                        height: 20,
                        width: 10,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ...List.generate(4, (index) {
              return TicketItem(
                seatNumber: '111', // Example seat number
                price: 'Ugx 10000', // Example price
              );
            }),
          ],
        ),
      ),
    );
  }
}
