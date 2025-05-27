import 'package:flutter/material.dart';
import 'package:movie_app2/core/theme/radius.dart';
import 'package:movie_app2/detail.dart';
import 'package:movie_app2/models/genres.dart';

class GridGenreItem extends StatelessWidget {
  const GridGenreItem({
    super.key,
    required this.genres,
  });

  final List<Genres> genres;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // chiều cao tổng thể của item
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return InkWell(
            onTap: () {
              Modular.to.pushNamed("/home/genres", arguments: {
                "genres": genre,
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 250,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: radius20,
                  color: Colors.blue,
                ),
                alignment: Alignment.center, // căn giữa nội dung
                child: Text(
                  genre.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis, // tránh text tràn
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
