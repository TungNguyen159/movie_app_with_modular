import 'package:flutter/material.dart';
import 'package:movie_app/features/Search/widgets/custom_search.dart';
import 'package:movie_app/features/Search/widgets/search_box.dart';
import 'package:movie_app/config/handle_api.dart';
import 'package:movie_app/models/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Movies>> searchInfo = Future.value([]);
  final searchController = TextEditingController();
  final controllerApis = controllerApi();
  void _search(String value) {
    value = value.toLowerCase();
    setState(() {
      searchInfo = controllerApis.searchMovie(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SearchBox(
              controller: searchController,
              onChanged: _search,
            ),
            const SizedBox(height: 20),
          
            Expanded(
              child: FutureBuilder<List<Movies>>(
                future: searchInfo,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); 
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ); 
                  } else if (snapshot.hasData) {
                    return CustomSearch(snapshot: snapshot);
                  }
                  return const Center(
                      child: Text(
                    "Không có dữ liệu",
                    style: TextStyle(color: Colors.white),
                  )); 
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
