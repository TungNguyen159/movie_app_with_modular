import 'package:flutter/material.dart';
import 'package:movie_app2/features/manage/screen/add_hall.dart';
import 'package:movie_app2/features/manage/widget/hall_list_item.dart';
import 'package:movie_app2/models/hall.dart';
import 'package:movie_app2/service/hall_service.dart';

class ManageHall extends StatefulWidget {
  const ManageHall({super.key});

  @override
  State<ManageHall> createState() => _ManageHallState();
}

class _ManageHallState extends State<ManageHall> {
  final hallService = HallService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hall"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<List<Hall>>(
                      stream: hallService.streamHall,
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text("Lỗi: ${snapshot.error}"));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text("Không có suất chiếu nào."));
                        }

                        final List<Hall> hallList = snapshot.data!;

                        return HallListItem(hall: hallList);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const AddHall()),
                    );
                  },
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
