class Payment {
  final String? paymentid;
  final String bookingid;
  final String vnptransactionNo;
  final String vnporderInfo;
  final String vnptransactiondate;
  final String? status;

  Payment({
    this.paymentid,
    required this.bookingid,
    required this.vnptransactionNo,
    required this.vnporderInfo,
    required this.vnptransactiondate,
    this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentid: json["id"],
      bookingid: json["booking_id"],
      vnptransactionNo: json["vnp_transactionno"],
      vnporderInfo: json["vnp_order_info"],
      vnptransactiondate: json["vnp_transactiondate"],
      status: json["payment_status"],
    );
  }
}
