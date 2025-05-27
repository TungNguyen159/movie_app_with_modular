import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/core/image/image_app.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/features/Onshowing/widgets/showtimestatus.dart';
import 'package:movie_app2/models/showtime.dart';
import 'package:movie_app2/service/movie_service.dart';

class OnshowingListItem extends StatelessWidget {
  const OnshowingListItem({
    super.key,
    required this.showtime,
  });
  final List<Showtime> showtime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin:
            const EdgeInsets.symmetric(horizontal: Gap.sM, vertical: Gap.sM),
        width: double.infinity,
        child: ListView.builder(
          itemCount: showtime.length,
          itemBuilder: (ctx, index) {
            final data = showtime[index];
            final dateText = DateFormat('dd/MM/yyyy').format(data.date);
            return Padding(
              padding: const EdgeInsets.only(top: Gap.sm),
              child: SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    Modular.to.pushNamed("/main/detail/${data.movieid}");
                  },
                  child: FutureBuilder(
                    future: MovieService().getmovieid(data.movieid),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Lỗi tải phim"));
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(child: Text("Không có dữ liệu"));
                      }
                      final movie = snapshot.data!;
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: Gap.sm),
                        child: Padding(
                          padding: const EdgeInsets.all(Gap.sm),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  movie.posterurl.isNotEmpty
                                      ? movie.posterurl
                                      : ImageApp.defaultImage,
                                  height: 120,
                                  width: 90,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      ImageApp.defaultImage,
                                      height: 140,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: Gap.sm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextHead(
                                      text: movie.title,
                                      maxLines: 2,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            size: 16, color: Colors.amber),
                                        const SizedBox(width: 4),
                                        Text(
                                          movie.average.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.timer,
                                            size: 16, color: Colors.blueGrey),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${data.starttime} - ${data.endtime}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.attach_money,
                                            size: 16, color: Colors.green),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${data.price} VND / Vé",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            size: 16, color: Colors.deepPurple),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Ngày chiếu: $dateText",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Gap.sm),
                                    Showtimestatus(
                                      date: data.date,
                                      starttime: data.starttime,
                                      endtime: data.endtime,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
