import 'package:flutter/material.dart';
import 'package:movie_app2/Components/back_button.dart';
import 'package:movie_app2/features/Home/widgets/grid_movie_item.dart';
import 'package:movie_app2/home.dart';
import 'package:movie_app2/models/movies.dart';
import 'package:movie_app2/service/movie_service.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  final movieService = MovieService();
  List<Movies> getMovie = []; // Danh sách phim
  int pages = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData(); // Tải dữ liệu ban đầu
  }

  // Hàm tải dữ liệu
  Future<void> loadData() async {
    if (isLoading) return; // Ngăn chặn tải nhiều lần
    setState(() => isLoading = true);
    try {
      final movies =
          await movieService.getmovies(page: pages, limit: 9); // Gọi API
      setState(() {
        getMovie.addAll(movies); // Thêm dữ liệu vào danh sách
        pages++; // Tăng số trang
      });
    } finally {
      setState(() => isLoading = false); // Kết thúc tải
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All movies"),
        leading: BackBind(
          onPressed: () {
            Modular.to.navigate("/main");
            //Modular.to.pop();
          },
        ),
      ),
      //list all movies
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            loadData();
          }
          return true;
        },
        child: getMovie.isEmpty && isLoading
            ? const Center(
                child: CircularProgressIndicator()) // Hiển thị loading ban đầu
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                  childAspectRatio: 0.7,
                ),
                itemCount: getMovie.length + (isLoading ? 1 : 0),
                itemBuilder: (ctx, index) {
                  if (index == getMovie.length) {
                    // Hiển thị loading khi đang tải thêm
                    return const Center(child: CircularProgressIndicator());
                  }
                  final movie = getMovie[index];
                  return GridMovieItem(movies: movie); // Hiển thị mỗi phim
                },
              ),
      ),
    );
  }
}
