import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app2/features/Search/widgets/custom_search.dart';
import 'package:movie_app2/features/Search/widgets/filter.dart';
import 'package:movie_app2/features/Search/widgets/search_box.dart';
import 'package:movie_app2/models/movies.dart';

import 'package:movie_app2/service/movie_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Movies>> searchInfo = Future.value([]);
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode(); // Tạo FocusNode để quản lý focus
  final movieService = MovieService();
  void _search(String value) {
    value = value.toLowerCase();
    setState(() {
      searchInfo = movieService.searchMovie(value);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FilterBottomSheet(
          onApplyFilters: _applyFilters,
        );
      },
    );
  }

  void _applyFilters(double minDuration, double maxDuration, double minRating,
      double maxRating) {
    setState(() {
      searchInfo = movieService.getmovie().then((movies) => movies
          .where((movie) =>
              movie.duration >= minDuration &&
              movie.duration <= maxDuration &&
              movie.average >= minRating &&
              movie.average <= maxRating)
          .toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchBox(
                    controller: searchController,
                    focusNode: searchFocusNode,
                    onChanged: _search,
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    showFilterBottomSheet(context);
                  },
                  icon: const Icon(Icons.filter_alt),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: searchInfo,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return Center(
                        child: Text(
                            "Error: ${snapshot.error ?? "Failed to load data"}"));
                  }
                  if (snapshot.data!.isEmpty) {
                    return const Center(child: Text("Search your movie!"));
                  }
                  final List<Movies> movielist = snapshot.data!;
                  return CustomSearch(movie: movielist);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
