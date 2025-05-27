import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/alert_dialog.dart';
import 'package:movie_app2/Components/showtime_helper.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/features/Yourbooking/widget/vnpay_list_item.dart';
import 'package:movie_app2/features/manage/widget/price_detail.dart';
import 'package:movie_app2/models/coupon.dart';
import 'package:movie_app2/service/booking_service.dart';
import 'package:movie_app2/service/coupon_service.dart';
import 'package:movie_app2/service/payment_service.dart';
import 'package:movie_app2/service/seat_service.dart';

class DetailBookingDialog extends StatefulWidget {
  const DetailBookingDialog({
    super.key,
    required this.bookingid,
    this.code,
    required this.status,
  });
  final String bookingid;
  final String? code;
  final String status;
  @override
  State<DetailBookingDialog> createState() => _DetailBookingDialogState();
}

class _DetailBookingDialogState extends State<DetailBookingDialog> {
  final seatService = SeatService();
  final couponService = CouponService();
  final bookingService = BookingService();
  int discount = 0; // % giảm giá nếu có coupon
  bool isPercentage = true;
  String couponCode = '';

  Future<void> fetchCouponDiscount() async {
    if (widget.code == null || widget.code!.isEmpty) {
      return;
    }
    Coupon? coupon = await couponService.checkCoupondetail(widget.code!);
    if (coupon != null && mounted) {
      setState(() {
        couponCode = coupon.code;
        discount = coupon.discount;
        isPercentage = coupon.ispercentage;
      });
    }
  }

  @override
  void initState() {
    fetchCouponDiscount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500, // Giới hạn chiều cao
      width: 400, // Giới hạn chiều rộng
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface, // Đặt màu trong BoxDecoration
        borderRadius: BorderRadius.circular(20), // Bo góc
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texttitle(text: "Seat"),
                Texttitle(text: "Type"),
                Texttitle(text: "Price"),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder(
                    future: seatService.getseat(widget.bookingid),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(
                            child: Text("Không có dữ liệu ghế"));
                      }
                      final data = snapshot.data!;
                      int totalPrice =
                          data.fold(0, (sum, seat) => sum + (seat.price ?? 0));
                      int discountAmount = isPercentage
                          ? (totalPrice * discount ~/ 100)
                          : discount; // Dùng ~/ để lấy kết quả nguyên
                      int priceAfterDiscount = totalPrice - discountAmount;
                      int tax = (totalPrice * 10 ~/ 100);
                      int finalTotal = priceAfterDiscount + tax;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListView.builder(
                                itemCount: data.length,
                                shrinkWrap: true, // Giúp tránh lỗi bố cục
                                itemBuilder: (ctx, index) {
                                  final seat = data[index];
                                  return CustomSeat(
                                      seat: seat.seatnumber!,
                                      price: seat.price.toString(),
                                      type: seat.type);
                                }),
                            const Divider(),
                            PriceDetail(
                                totalPrice: totalPrice,
                                taxAmount: tax,
                                code: couponCode.isNotEmpty
                                    ? couponCode
                                    : "Không có mã giảm giá",
                                discountAmount: discountAmount,
                                finalPrice: finalTotal),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (data.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Không có thông tin ghế để xử lý huỷ đơn!")),
                                    );
                                    return;
                                  }
                                  final showStartTime =
                                      ShowtimeHelper.getShowStartTime(
                                          data.first.showtime!);
                                  final now = DateTime.now();
                                  final diff = showStartTime.difference(now);
                                  if (diff.inMinutes <= 30) {
                                    if (widget.status == "canceled") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Đơn hàng đã bị hủy, không thể huỷ lại!")),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Không thể huỷ đơn hàng trước thời gian chiếu 30 phút!")),
                                      );
                                    }
                                    return;
                                  }
                                  _onCancel(widget.bookingid);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(40),
                                ),
                                child: const Text("Huỷ đơn hàng"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  FutureBuilder(
                      future: VNPAYFlutter().getPaymentbyid(widget.bookingid),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                              child: Text("Không có dữ liệu thanh toán"));
                        }
                        final datas = snapshot.data!;
                        return Vnpaylistitem(data: datas);
                      }),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue, // Đặt màu tại đây
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: IconButton(
              onPressed: () {
                Modular.to.pop(); // Đóng dialog
              },
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  _onCancel(String bookingid) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => const CustomAlertDialog(
        title: "Xác nhận",
        description: "Bạn có chắc chắn muốn hủy đơn đặt vé này?",
        confirmText: "Có",
        cancelText: "Không",
      ),
    );

    if (result == true) {
      bookingService.updatestatusCancel(bookingid);
      seatService.deleteSeat(bookingid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đơn đặt vé đã bị hủy.")),
      );
      Navigator.pop(context, true);
    }
  }
}

class Texttitle extends StatelessWidget {
  const Texttitle({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextHead(
      text: text,
      textStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold),
    );
  }
}

class CustomSeat extends StatelessWidget {
  const CustomSeat({
    super.key,
    required this.seat,
    required this.price,
    required this.type,
  });
  final String seat;
  final String price;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Texttitle(text: seat),
          Texttitle(text: type),
          Texttitle(text: price),
        ],
      ),
    );
  }
}
