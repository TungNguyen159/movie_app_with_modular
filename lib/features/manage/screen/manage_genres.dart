import 'package:flutter/material.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/features/manage/screen/add_genres.dart';
import 'package:movie_app2/features/manage/widget/genres_list_item.dart';
import 'package:movie_app2/models/genres.dart';
import 'package:movie_app2/service/genres_service.dart';

class ManageGenres extends StatefulWidget {
  const ManageGenres({super.key});

  @override
  State<ManageGenres> createState() => _ManageGenresState();
}

class _ManageGenresState extends State<ManageGenres> {
  final genresService = GenresService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextHead(text: "Manage Genres"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                        stream: genresService.genresstream,
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text("Lỗi: ${snapshot.error}"));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text("Không có thể loại nào."));
                          }

                          final List<Genres> genreslist = snapshot.data!;

                          return GenresListItem(genres: genreslist);
                        }),
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
                      MaterialPageRoute(builder: (ctx) => const AddGenres()),
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
