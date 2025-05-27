import 'package:flutter/material.dart';
import 'package:movie_app2/service/booking_service.dart';
import 'package:movie_app2/service/movie_service.dart';

class StatisticMovie extends StatelessWidget {
  const StatisticMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingService = BookingService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistic movie"),
      ),
      body: FutureBuilder(
        future: bookingService.getStatisticmovie(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có dữ liệu "));
          }
          final bookinglist = snapshot.data!;
          bookinglist.sort((a, b) =>
              (b["total_revenue"] as num).compareTo(a["total_revenue"] as num));
         
          return ListView.builder(
            itemCount: bookinglist.length,
            itemBuilder: (ctx, index) {
              final stats = bookinglist[index];

              return FutureBuilder(
                future: MovieService().getmovieid(stats["movieid"]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text("Lỗi tải dữ liệu phim"));
                  }

                  final movie = snapshot.data!;

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          // Ảnh Poster LỚN HƠN
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              movie.posterurl,
                              width: 90,
                              height: 130,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 90,
                                height: 130,
                                color: Colors.grey[300],
                                child: const Icon(Icons.movie,
                                    size: 40, color: Colors.black54),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Khoảng cách giữa ảnh và text
                          // Thông tin phim
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                              width: 16), // Khoảng cách giữa text và total
                          // Tổng doanh thu
                          Text(
                            "${stats["total_revenue"]} VND",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
