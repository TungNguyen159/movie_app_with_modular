import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/models/reviews.dart';
import 'package:movie_app2/service/user_service.dart';

class ReviewListItem extends StatelessWidget {
  const ReviewListItem({super.key, required this.reviews});
  final List<Reviews> reviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gap.sM, horizontal: Gap.mL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180, // cố định chiều cao
            child: reviews.isEmpty
                ? const Center(child: Text('Chưa có đánh giá nào'))
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: reviews.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (ctx, index) {
                      final review = reviews[index];
                      final dateText =
                          DateFormat("dd/MM/yyyy").format(review.createdat!);
                      return Container(
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FutureBuilder(
                                    future: UserService()
                                        .getUserbyid(review.userid!),
                                    builder: (ctx, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return const Center(
                                            child: Text("Lỗi tải phim"));
                                      } else if (!snapshot.hasData ||
                                          snapshot.data == null) {
                                        return const Center(
                                            child: Text("Không có dữ liệu"));
                                      }
                                      final datas = snapshot.data!;
                                      return Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundImage: (datas.imageurl ==
                                                        null ||
                                                    datas.imageurl!.isEmpty)
                                                ? const AssetImage(
                                                        "assets/no_image.png")
                                                    as ImageProvider
                                                : NetworkImage(datas.imageurl!),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(datas.name),
                                        ],
                                      );
                                    }),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    dateText,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            RatingBarIndicator(
                              rating: review.rate.toDouble(),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: Text(
                                review.content,
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
