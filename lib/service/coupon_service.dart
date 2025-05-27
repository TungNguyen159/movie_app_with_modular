import 'package:movie_app2/models/coupon.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CouponService {
  final supabase = Supabase.instance.client;

  Future<void> insertCoupon(Coupon coupon) async {
    await supabase.from("coupons").insert({
      "code": coupon.code,
      "discount": coupon.discount,
      "is_percentage": coupon.ispercentage,
      "expires_at": coupon.expiretime.toIso8601String()
    });
  }

  final streamcoupon = Supabase.instance.client
      .from("coupons")
      .stream(primaryKey: ["id"]).map(
          (data) => data.map((e) => Coupon.fromJson(e)).toList());
  // Future<List<Coupon>> readCoupon() async {
  //   final response = await supabase.from('coupons').select();
  //   return response.map((e) => Coupon.fromJson(e)).toList();
  // }

  Future<void> updateCoupon(Coupon coupon) async {
    await supabase.from("coupons").update({
      "code": coupon.code,
      "discount": coupon.discount,
      "is_percentage": coupon.ispercentage,
      "expires_at": coupon.expiretime.toIso8601String()
    }).eq("id", coupon.couponid!);
  }

  Future<void> deleteCoupon(Coupon coupon) async {
    await supabase.from("coupons").delete().eq("id", coupon.couponid!);
  }

  Future<Coupon?> checkCoupon(String code) async {
    final response =
        await supabase.from("coupons").select().eq("code", code).maybeSingle();
    if (response == null || response.isEmpty) return null;
    Coupon coupon = Coupon.fromJson(response);

    // Kiểm tra ngày hết hạn
    if (coupon.expiretime.isBefore(DateTime.now())) {
      return null; // Mã giảm giá đã hết hạn
    }

    return coupon;
  }

  Future<Coupon?> checkCoupondetail(String couponid) async {
    final response =
        await supabase.from("coupons").select().eq("id", couponid).maybeSingle();
    if (response == null || response.isEmpty) return null;

    return Coupon.fromJson(response);
  }
}
