import 'package:flutter/material.dart';
import 'package:movie_app2/Components/alert_dialog.dart';
import 'package:movie_app2/features/manage/screen/add_genres.dart';
import 'package:movie_app2/models/genres.dart';
import 'package:movie_app2/service/genres_service.dart';

class GenresListItem extends StatelessWidget {
  const GenresListItem({super.key, required this.genres});
  final List<Genres> genres;
  @override
  Widget build(BuildContext context) {
    final genresService = GenresService();
    onDelete(Genres genresid) async {
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) => const CustomAlertDialog(
          title: "Xác nhận",
          description: "Bạn có chắc chắn muốn xóa thể loại này?",
          confirmText: "Có",
          cancelText: "Không",
        ),
      );
      if (result == true) {
        final hasgenre = await genresService.checkgenre(genresid);
        if (hasgenre) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    "Thể loại này đã có trong phim vui lòng kiểm tra lại")),
          );
          return;
        }
        await genresService.deleteGenres(genresid);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Xóa thành công!")),
        );
      }
    }

    return ListView.builder(
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final genre = genres[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(
              genre.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddGenres(genres: genre),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(genre),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
