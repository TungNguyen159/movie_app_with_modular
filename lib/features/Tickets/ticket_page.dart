import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/app_elevated_button.dart';
import 'package:movie_app/Widgets/text_head.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("name movie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            date(),
            time(),
            room(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppElevatedButton(text: "cancel"),
                AppElevatedButton(text: "continue"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column date() {
    return Column(
      children: [
        TextHead(
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
    );
  }

  Column time() {
    return Column(
      children: [
        TextHead(
          text: "select a time",
        ),
        const SizedBox(height: 10),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
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
                    child: TextHead(text: "7:00 PM"),
                  )),
              Container(
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
                    child: TextHead(text: "7:00 PM"),
                  )),
              Container(
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
                    child: TextHead(text: "7:00 PM"),
                  )),
            ],
          ),
        )
      ],
    );
  }

  Column room() {
    return Column(
      children: [
        TextHead(
          text: "select a cinema",
        ),
        const SizedBox(height: 10),
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
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
                    child: TextHead(text: "2D"),
                  )),
              Container(
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
                    child: TextHead(text: "3D"),
                  )),
              Container(
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
                    child: TextHead(text: "IMAX"),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
