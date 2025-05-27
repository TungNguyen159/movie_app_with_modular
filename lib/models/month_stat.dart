class MonthlyRevenueStats {
  final String month;
  final int totalRevenue;
  final int bookingCount;

  MonthlyRevenueStats({
    required this.month,
    required this.totalRevenue,
    required this.bookingCount,
  });

  factory MonthlyRevenueStats.fromJson(Map<String, dynamic> json) {
    return MonthlyRevenueStats(
        month: json["month"],
        totalRevenue: json["totalRevenue"],
        bookingCount: json["bookingCount"]);
  }
}
