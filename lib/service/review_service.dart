import 'package:movie_app2/models/reviews.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewService {
  final supabase = Supabase.instance.client;

  Future<void> insertReview(Reviews reviews) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;
    await supabase.from("reviews").insert({
      'user_id': user.id,
      'movie_id': reviews.movieid,
      'rate': reviews.rate,
      'content': reviews.content,
    });
  }

  Future<List<Reviews>> getReviews(String movieid) async {
    final response =
        await supabase.from("reviews").select().eq("movie_id", movieid);
    return response.map((e) => Reviews.fromJson(e)).toList();
  }
}
