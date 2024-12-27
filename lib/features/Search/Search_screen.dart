import 'dart:async'; // Để sử dụng debounce
import 'package:flutter/material.dart';
import 'package:movie_app/Widgets/list_display.dart';
import 'package:movie_app/Widgets/text_head.dart';
import 'package:movie_app/config/api_handle.dart';
import 'package:movie_app/features/Search/widgets/custom_search.dart';
import 'package:movie_app/features/Search/widgets/search_box.dart';
import 'package:movie_app/models/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<List<Movies>> searchInfo = Future.value([]);
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode(); // Tạo FocusNode để quản lý focus
  final controllerApis = ControllerApi();
  void _search(String value) {
    value = value.toLowerCase();
    setState(() {
      searchInfo = controllerApis.searchMovie(value);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
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
              focusNode: searchFocusNode,
              onChanged: _search,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListDisplay<Movies>(
                listFuture: searchInfo,
                builder: (snapshot) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: TextHead(
                        text: "Không có dữ liệu",
                        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    );
                  }
                  return CustomSearch(snapshot: snapshot);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
