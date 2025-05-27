import 'package:flutter/material.dart';
import 'package:movie_app2/Components/back_button.dart';
import 'package:movie_app2/Components/showtime_helper.dart';
import 'package:movie_app2/detail.dart';
import 'package:movie_app2/features/details/widgets/review_list_item.dart';
import 'package:movie_app2/models/showtime.dart';
import 'package:movie_app2/service/favorite_service.dart';
import 'package:movie_app2/service/movie_service.dart';
import 'package:movie_app2/service/review_service.dart';
import 'package:movie_app2/service/showtime_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.movieId});
  final String movieId;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final movieService = MovieService();
  final showtimeService = ShowtimeService();
  final favoriteService = FavoriteService();
  final reviewService = ReviewService();
  bool isFavorite = false;
  String favouriteId = "";
  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    String? favorid = await favoriteService.checkIfFavorite(widget.movieId);
    setState(() {
      isFavorite = favorid != null;
      favouriteId = favorid ?? "";
    });
  }

  void _checkShowtimeAndNavigate() async {
    List<Showtime> showtimes =
        await showtimeService.getShowtimeMovieid(widget.movieId);

    final List<Showtime> filteredShowtimeList = showtimes
        .where((show) =>
            show.status?.toLowerCase() != "canceled" &&
            ShowtimeHelper.getShowEndTime(show).isAfter(DateTime.now()) &&
            show.halls!.status?.toLowerCase() != "closed")
        .toList();

    if (filteredShowtimeList.isNotEmpty) {
      Modular.to.pushNamed('/main/detail/ticket/${widget.movieId}');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Thông báo"),
            content: const Text(
                "Phim này hiện không có suất chiếu hoặc không có phòng!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackBind(
          onPressed: () {
            Modular.to.pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: FutureBuilder(
                future: movieService.getmovieid(widget.movieId),
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final snapshots = snapshot.data!;
                    return CustomDetail(movie: snapshots);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(
              child: ListDisplay(
                  listFuture: movieService.getmovie(),
                  builder: (snapshot) => RecommendScreen(movie: snapshot)),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: TextHead(text: "Reviews"),
            ),
            SizedBox(
              child: ListDisplay(
                  listFuture: reviewService.getReviews(widget.movieId),
                  builder: (review) => ReviewListItem(reviews: review)),
            ),
            Padding(
              padding: const EdgeInsets.all(Gap.mL),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1, // Chiếm 1/5 tổng width (1 phần)
                    child: IconButton(
                      onPressed: () async {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        if (isFavorite) {
                          await favoriteService.insertfavorite(widget.movieId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Đã thêm vào yêu thích!")),
                          );
                        } else {
                          await favoriteService.deletefavorite(widget.movieId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Đã xóa khỏi yêu thích!")),
                          );
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorite
                            ? Colors.red
                            : Theme.of(context).colorScheme.onPrimary,
                        size: 30,
                      ),
                    ),
                  ),
                  Gap.mLWidth,
                  Expanded(
                    flex: 4, // Chiếm 4/5 tổng width (4 phần)
                    child: AppButton(
                      text: "Get Ticket",
                      onPressed: _checkShowtimeAndNavigate,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
