class Coupon {
  final String? couponid;
  final String code;
  final int discount;
  final bool ispercentage;
  final DateTime expiretime;
  final DateTime? createat;

  Coupon({
    this.couponid,
    required this.code,
    required this.discount,
    required this.expiretime,
    required this.ispercentage,
    this.createat,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      couponid: json["id"],
      code: json["code"],
      discount: json["discount"],
      ispercentage: json["is_percentage"],
      expiretime:
          DateTime.parse(json["expires_at"]), 
      createat: json["created_at"] != null
          ? DateTime.parse(json["created_at"])
          : null,
    );
  }
}