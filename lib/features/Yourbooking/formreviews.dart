import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app2/models/reviews.dart';
import 'package:movie_app2/service/booking_service.dart';
import 'package:movie_app2/service/review_service.dart';

class Formreviews extends StatefulWidget {
  final String movieId;
  final String bookingid;
  const Formreviews(
      {super.key, required this.movieId, required this.bookingid});

  @override
  State<Formreviews> createState() => _FormreviewsState();
}

class _FormreviewsState extends State<Formreviews> {
  final _commentController = TextEditingController();
  final _fromkey = GlobalKey<FormState>();
  final reviews = ReviewService();
  final booking = BookingService();
  double rate = 0;
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview() async {
    if (!_fromkey.currentState!.validate()) return;
    final int rating = rate.toInt();
    final String content = _commentController.text;
    await reviews.insertReview(Reviews(
      movieid: widget.movieId,
      rate: rating,
      content: content,
    ));
    await booking.updatereviewed(widget.bookingid);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cảm ơn bạn đã đánh giá!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đánh giá phim')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _fromkey,
          child: Column(
            children: [
              Text(
                "Chọn số sao",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    rate = rating;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Nhận xét phim',
                ),
                maxLength: 200,
                maxLines: 5,
                validator: (value) =>
                    value!.isEmpty ? 'vui lòng nhập thông tin' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitReview,
                child: const Text('Gửi đánh giá'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
