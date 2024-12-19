import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/text_head.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const TextHead(
            text: "select a date",
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ), //
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextHead(text: "monday"),
                          TextHead(text: "18"),
                        ],
                      ),
                    )),
                Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ), //
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextHead(text: "monday"),
                          TextHead(text: "18"),
                        ],
                      ),
                    )),
                Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ), //
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextHead(text: "monday"),
                          TextHead(text: "18"),
                        ],
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
