import 'package:flutter/material.dart';
import 'package:movie_app2/features/manage/screen/add_coupon.dart';
import 'package:movie_app2/features/manage/widget/coupon_list_item.dart';
import 'package:movie_app2/models/coupon.dart';
import 'package:movie_app2/service/coupon_service.dart';

class ManageCoupon extends StatefulWidget {
  const ManageCoupon({super.key});

  @override
  State<ManageCoupon> createState() => _ManageCouponState();
}

class _ManageCouponState extends State<ManageCoupon> {
  final couponService = CouponService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coupon"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: couponService.streamcoupon,
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text("Lỗi: ${snapshot.error}"));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text("Không có mã nào."));
                        }

                        final List<Coupon> couponList = snapshot.data!;
                        return CouponListItem(coupon: couponList);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const AddCoupon()),
                    );
                  },
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
