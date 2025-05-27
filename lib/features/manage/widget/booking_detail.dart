import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/Components/alert_dialog.dart';
import 'package:movie_app2/Components/app_button.dart';
import 'package:movie_app2/Components/showtime_helper.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/core/image/image_app.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/features/Checking/widgets/billing_details.dart';
import 'package:movie_app2/features/Yourbooking/widget/vnpay_list_item.dart';
import 'package:movie_app2/features/manage/widget/price_detail.dart';
import 'package:movie_app2/models/coupon.dart';
import 'package:movie_app2/models/seat.dart';
import 'package:movie_app2/service/booking_service.dart';
import 'package:movie_app2/service/coupon_service.dart';
import 'package:movie_app2/service/movie_service.dart';
import 'package:movie_app2/service/payment_service.dart';
import 'package:movie_app2/service/seat_service.dart';

class BookingDetail extends StatefulWidget {
  const BookingDetail({super.key});

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  final seatService = SeatService();
  final couponService = CouponService();
  final bookingService = BookingService();
  late String selectedBookingId;
  int discount = 0; // % giảm giá nếu có coupon
  String couponid = '';
  String couponCode = '';
  bool isPercentage = true;
  @override
  void initState() {
    selectedBookingId = Modular.args.data["bookingid"] ?? '';
    super.initState();
  }

  Future<void> _fetchCouponDiscount() async {
    Coupon? coupon = await couponService.checkCoupondetail(couponid);
    if (coupon != null && mounted) {
      setState(() {
        couponCode = coupon.code;
        discount = coupon.discount;
        isPercentage = coupon.ispercentage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chi tiết đặt vé")),
      body: FutureBuilder<List<Seat>>(
        future: seatService.getseat(selectedBookingId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có ghế nào được đặt."));
          }

          final seatList = snapshot.data!;

          int totalPrice =
              seatList.fold(0, (sum, seat) => sum + (seat.price ?? 0));
          int discountAmount = isPercentage
              ? (totalPrice * discount ~/ 100) // Dùng ~/ để lấy kết quả nguyên
              : discount;
          int priceAfterDiscount = totalPrice - discountAmount;
          int tax = (totalPrice * 10 ~/ 100);
          int finalTotal = priceAfterDiscount + tax;
          return FutureBuilder(
            future: bookingService.getbookingbyid(selectedBookingId),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Lỗi: ${snapshot.error}"));
              }
              if (!snapshot.hasData) {
                return const Center(child: Text("Không có ghế nào được đặt."));
              }
              final bookings = snapshot.data!;
              final endtime = ShowtimeHelper.getShowEndTime(bookings.showtime!);
              //check coupon
              if (couponCode.isEmpty &&
                  bookings.couponid != null &&
                  bookings.couponid!.isNotEmpty) {
                couponid = bookings.couponid!;
                _fetchCouponDiscount();
              }
              final datetext = DateFormat('dd/MM/yyyy HH:mm')
                  .format(DateTime.parse(bookings.time!));
              final datetexts =
                  DateFormat('dd/MM/yyyy').format(bookings.showtime!.date);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        FutureBuilder(
                          future: MovieService()
                              .getmovieid(bookings.showtime!.movieid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2));
                            }
                            final movies = snapshot.data;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: movies!.posterurl.isNotEmpty
                                          ? Image.network(
                                              movies.posterurl,
                                              width: 90,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              ImageApp.defaultImage,
                                              width: 90,
                                              height: 130,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextHead(
                                              text: movies.title,
                                              maxLines: 2,
                                            ),
                                            Gap.smHeight,
                                            Text(
                                                "Time: ${bookings.showtime!.starttime} - ${bookings.showtime!.endtime}"),
                                            Gap.smHeight,
                                            Text("Ngày chiếu: $datetexts"),
                                            Gap.smHeight,
                                            Text("Ngày đặt: $datetext")
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Chip(
                                        label: Text(
                                          bookings.status!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        backgroundColor:
                                            bookings.status! == "paid"
                                                ? Colors.green
                                                : bookings.status! == "canceled"
                                                    ? Colors.grey
                                                    : Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: BillingDetails(selectedSeats: seatList),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: PriceDetail(
                        totalPrice: totalPrice,
                        taxAmount: tax,
                        code: couponCode.isNotEmpty
                            ? couponCode
                            : "Không có mã giảm giá",
                        discountAmount: discountAmount,
                        finalPrice: finalTotal,
                      ),
                    ),
                    FutureBuilder(
                        future:
                            VNPAYFlutter().getPaymentbyid(selectedBookingId),
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
                          final data = snapshot.data!;
                          return Vnpaylistitem(data: data);
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: AppButton(
                              text: 'Hủy đơn',
                              onPressed: (bookings.status == "paid" &&
                                      endtime.isBefore(DateTime.now()))
                                  ? () => ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                          content: Text("không thể huỷ đơn do đã qua giờ chiếu")))
                                  : () => _onCancel(
                                        selectedBookingId,
                                      ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AppButton(
                                text: 'Thanh toán',
                                onPressed: () {
                                  if (bookings.status == "canceled" ||
                                      bookings.status == "paid" ||
                                      endtime.isBefore(DateTime.now())) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Không thể thanh toán do đã thanh toán hoặc hết hạn")));
                                  } else {
                                    _onUpdate(selectedBookingId);
                                  }
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  _onUpdate(String bookingid) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => const CustomAlertDialog(
        title: "Xác nhận",
        description: "Xác nhận thanh toán",
        confirmText: "Có",
        cancelText: "Không",
      ),
    );
    if (result == true) {
      await bookingService.updatestatus(bookingid);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cập nhật thành công")),
      );
      Navigator.pop(context, true);
    }
  }

  _onCancel(
    String bookingid,
  ) async {
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
