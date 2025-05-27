import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/app_button.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/features/Checking/widgets/billing_details.dart';
import 'package:movie_app2/models/booking.dart';
import 'package:movie_app2/models/coupon.dart';
import 'package:movie_app2/models/payment.dart';
import 'package:movie_app2/models/seat.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/service/booking_service.dart';
import 'package:movie_app2/service/coupon_service.dart';
import 'package:movie_app2/service/payment_service.dart';
import 'package:movie_app2/service/seat_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late List<Seat> selectedSeats;
  late String selectedShowtimeId;
  int totalPrice = 0;
  int taxAmount = 0;
  int finalPrice = 0;
  int discountAmount = 0;
  String appliedCoupon = '';
  final currencyFormatter = NumberFormat("#,###", "vi_VN");
  final seatService = SeatService();
  final bookingService = BookingService();
  final couponService = CouponService();
  final vNPAYFlutter = VNPAYFlutter();
  String txnRef = DateTime.now().millisecondsSinceEpoch.toString();
  final TextEditingController couponController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final data = Modular.args.data;
    selectedSeats = (data?['selectedSeat'] as List?)?.cast<Seat>() ?? [];
    selectedShowtimeId = data['selectedShowtimeId'] ?? "";
    _calculateTotalPrice();
  }

  void processPayment(int price) {
    String paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      txnRef: txnRef,
      amount: price,
    );
    VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) async {
        try {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Thanh toán thành công")),
          );
          // Tạo booking
          final String? bookingIds =
              await bookingService.insertBookingvnp(Booking(
            showtimeid: selectedShowtimeId,
            totalprice: finalPrice,
            couponid: (appliedCoupon.isNotEmpty) ? appliedCoupon : null,
          ));

          if (bookingIds == null) {
            throw Exception("Lỗi khi tạo booking!");
          }

          // Lưu danh sách ghế
          List<Future<void>> seatInsertFutures = selectedSeats.map((seat) {
            return seatService.insertseat(
              Seat(
                bookingid: bookingIds,
                showtimeId: selectedShowtimeId,
                seatnumber: seat.seatnumber,
                type: seat.type,
                price: seat.price,
              ),
            );
          }).toList();

          await Future.wait(seatInsertFutures);

          // Lưu thông tin thanh toán
          final paymentData = Payment(
            bookingid: bookingIds,
            vnptransactionNo: params['vnp_TransactionNo'],
            vnporderInfo: params['vnp_OrderInfo'],
            vnptransactiondate: txnRef,
          );

          await vNPAYFlutter.insertpayment(paymentData);

          await Future.delayed(const Duration(seconds: 1));

          if (context.mounted) {
            // Đóng dialog loading trước khi chuyển trang
            Navigator.of(context).pop();
            Modular.to.pushNamed("/main/detail/ticket/confirm");
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lỗi khi xử lý thanh toán: $e")),
          );
        }
      },
      onPaymentError: (params) {
        print("Thanh toán thất bại: $params");
      },
      context: context,
    );
  }

  void _calculateTotalPrice() {
    totalPrice = selectedSeats.fold(0, (sum, seat) => sum + (seat.price ?? 0));
    taxAmount = (totalPrice * 0.1).round(); // 10% thuế
    finalPrice = totalPrice + taxAmount - discountAmount;
    setState(() {});
  }

  void _applyCoupon() async {
    String couponCode = couponController.text.trim().toUpperCase();

    // Gọi API kiểm tra mã giảm giá
    Coupon? coupons = await couponService.checkCoupon(couponCode);
    setState(() {
      if (coupons != null) {
        appliedCoupon = coupons.couponid!;
        int calculatedDiscount = coupons.ispercentage
            ? (totalPrice * coupons.discount ~/ 100)
            : coupons.discount;

        if (calculatedDiscount > totalPrice) {
          calculatedDiscount = 0;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    " Mã giảm giá không hợp lệ! Giá trị giảm giá lớn hơn tổng tiền!")),
          );
        }
        discountAmount = calculatedDiscount;
      } else {
        discountAmount = 0;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Mã giảm giá không hợp lệ hoặc đã hết hạn!")),
        );
      }

      _calculateTotalPrice();
    });
  }

  void _handlePayment() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final String? bookingIds = await bookingService.insertBooking(Booking(
        showtimeid: selectedShowtimeId,
        totalprice: finalPrice,
        couponid: (appliedCoupon.isNotEmpty) ? appliedCoupon : null,
      ));
      List<Future<void>> seatInsertFutures = selectedSeats.map((seat) {
        return seatService.insertseat(
          Seat(
            bookingid: bookingIds,
            showtimeId: selectedShowtimeId,
            seatnumber: seat.seatnumber,
            type: seat.type,
            price: seat.price,
          ),
        );
      }).toList();

      await Future.wait(seatInsertFutures);
      await Future.delayed(const Duration(seconds: 2));

      Navigator.pop(context);
      Modular.to.pushNamed("/main/detail/ticket/confirm");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi thanh toán: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextHead(text: "Thanh toán")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),

                // Chi tiết đặt chỗ
                BillingDetails(selectedSeats: selectedSeats),

                const SizedBox(height: 20),

                // Ô nhập mã giảm giá
                TextField(
                  controller: couponController,
                  decoration: InputDecoration(
                    labelText: "Nhập mã giảm giá",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      onPressed: _applyCoupon,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Tổng tiền & Thuế
                _buildPriceDetails(),

                const SizedBox(height: 20),

                // Nút thanh toán
                AppButton(
                  text: 'Đặt vé',
                  onPressed: _handlePayment,
                ),
                const SizedBox(height: 20),

                AppButton(
                  text: 'Thanh toán qua vnpay',
                  onPressed: () => processPayment(finalPrice),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceDetails() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Tổng: ${currencyFormatter.format(totalPrice)} VNĐ",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            "Thuế (10%): ${currencyFormatter.format(taxAmount)} VNĐ",
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          if (discountAmount > 0)
            Text(
              "Giảm giá: -${currencyFormatter.format(discountAmount)} VNĐ",
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
          const Divider(color: Colors.black, thickness: 1),
          Text(
            "Tổng tiền: ${currencyFormatter.format(finalPrice)} VNĐ",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
