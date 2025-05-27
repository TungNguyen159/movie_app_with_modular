import 'package:flutter/material.dart';
import 'package:movie_app2/Components/alert_dialog.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/features/manage/screen/add_movie.dart';
import 'package:movie_app2/models/movies.dart';
import 'package:movie_app2/service/movie_service.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({super.key, required this.movie});
  final List<Movies> movie;

  @override
  Widget build(BuildContext context) {
    final movieService = MovieService();
    onDelete(Movies movieid) async {
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) => const CustomAlertDialog(
          title: "Xác nhận",
          description: "Bạn có chắc chắn muốn xóa phim này?",
          confirmText: "Có",
          cancelText: "Không",
        ),
      );
      if (result == true) {
        await movieService.deleteMovie(movieid);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Xóa thành công!")),
        );
      }
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: movie.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final movies = movie[index];

        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster phim
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movies.posterurl,
                    width: 60,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 60,
                      height: 90,
                      color: Colors.grey[300],
                      child: const Icon(Icons.movie,
                          size: 40, color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Thông tin phim
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextHead(
                        text: movies.title,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Time: ${movies.duration} min",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            "${movies.average}/10",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Nút chỉnh sửa và xoá
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => AddMoviePage(movie: movies),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () => onDelete(movies),
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
