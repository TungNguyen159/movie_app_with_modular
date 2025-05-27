import 'package:flutter/material.dart';
import 'package:movie_app2/features/Search/widgets/search_box.dart';
import 'package:movie_app2/features/manage/screen/add_movie.dart';
import 'package:movie_app2/features/manage/widget/movie_list_item.dart';
import 'package:movie_app2/models/movies.dart';
import 'package:movie_app2/service/movie_service.dart';

class ManageMovie extends StatefulWidget {
  const ManageMovie({super.key});

  @override
  State<ManageMovie> createState() => _ManageMovieState();
}

class _ManageMovieState extends State<ManageMovie> {
  final movieService = MovieService();
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String _) => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý phim')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBox(
              controller: searchController,
              focusNode: searchFocusNode,
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<List<Movies>>(
                stream: movieService.streamMovies,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Lỗi: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Không có phim nào."));
                  }

                  final query = searchController.text.toLowerCase();
                  final movies = snapshot.data!
                      .where(
                          (movie) => movie.title.toLowerCase().contains(query))
                      .toList();

                  return MovieListItem(movie: movies);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddMoviePage()),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
