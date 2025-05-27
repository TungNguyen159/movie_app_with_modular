import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/Components/alert_dialog.dart';
import 'package:movie_app2/features/manage/screen/add_coupon.dart';
import 'package:movie_app2/models/coupon.dart';
import 'package:movie_app2/service/coupon_service.dart';

class CouponListItem extends StatelessWidget {
  final List<Coupon> coupon;
  
  const CouponListItem({
    super.key,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    _onDelete(Coupon couponid) async {
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) => const CustomAlertDialog(
          title: "Xác nhận",
          description: "Bạn có chắc chắn muốn xóa suất chiếu này?",
          confirmText: "Có",
          cancelText: "Không",
        ),
      );
      if (result == true) {
        await CouponService().deleteCoupon(couponid);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Xóa thành công!")),
        );
      }
    }

    return ListView.builder(
      itemCount: coupon.length,
      itemBuilder: (context, index) {
        final coupons = coupon[index];
        final isExpired = coupons.expiretime.isBefore(DateTime.now());
        final expireText = isExpired
            ? "Đã hết hạn"
            : "Còn hạn đến ${DateFormat('dd/MM/yyyy').format(coupons.expiretime)}";

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: Icon(
              Icons.local_offer,
              color: isExpired ? Colors.grey : Colors.green,
            ),
            title: Text(
              coupons.code.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Giảm: ${coupons.ispercentage ? "${coupons.discount}%" : "${coupons.discount}đ"}\n$expireText",
              style: TextStyle(color: isExpired ? Colors.red : Colors.black),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => AddCoupon(coupon: coupons)),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _onDelete(coupons),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
