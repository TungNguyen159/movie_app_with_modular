import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/models/month_stat.dart';
import 'package:movie_app2/service/booking_service.dart';

class StatisticMonth extends StatefulWidget {
  const StatisticMonth({
    super.key,
  });

  @override
  State<StatisticMonth> createState() => _StatisticMonthState();
}

class _StatisticMonthState extends State<StatisticMonth> {
  List<MonthlyRevenueStats> monthlyStats = [];
  List<int> years = []; // Danh sách các năm có dữ liệu
  int selectedYear = DateTime.now().year; // Mặc định là năm hiện tại
  bool isLoading = true;
  final bookingService = BookingService();
  Map<String, int> statusCount = {};
  @override
  void initState() {
    super.initState();
    fetchData();
    _fetchBookingStatusCount();
  }

  Future<void> _fetchBookingStatusCount() async {
    final counts = await bookingService.getBookingStatusCount();
    setState(() {
      statusCount = counts;
    });
  }

  void fetchData() async {
    final stats = await bookingService.fetchMonthlyRevenue();

    // Tách năm từ "YYYY-MM"
    List<int> extractedYears = stats
        .map((stat) {
          return int.parse(stat.month.split('-')[0]); // Lấy phần năm
        })
        .toSet()
        .toList(); // Loại bỏ trùng lặp

    // Lọc dữ liệu theo năm đã chọn
    final filteredStats = stats.where((stat) {
      return int.parse(stat.month.split('-')[0]) == selectedYear;
    }).toList();

    setState(() {
      monthlyStats = filteredStats;
      years = extractedYears..sort(); // Sắp xếp danh sách năm
      isLoading = false;
    });
  }

  void onYearChanged(int year) {
    setState(() {
      selectedYear = year;
      isLoading = true;
    });
    fetchData(); // Lọc lại dữ liệu theo năm mới chọn
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Chọn năm:', style: TextStyle(fontSize: 16)),
                      DropdownButton<int>(
                        value: selectedYear,
                        onChanged: (year) {
                          if (year != null) {
                            onYearChanged(year);
                          }
                        },
                        items: years.map((year) {
                          return DropdownMenuItem<int>(
                            value: year,
                            child: Text(year.toString()),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: monthlyStats.isEmpty
                      ? const Center(child: Text('Không có dữ liệu'))
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _buildRevenueChart(),
                                _buildMonthlyStatsList(),
                                _buildSummaryCards(),
                                ListTile(
                                  title: const Text('Paid'),
                                  trailing: TextHead(
                                      text: statusCount['paid']?.toString() ??
                                          '0'),
                                ),
                                ListTile(
                                  title: const Text('Pending'),
                                  trailing: TextHead(
                                      text:
                                          statusCount['pending']?.toString() ??
                                              '0'),
                                ),
                                ListTile(
                                  title: const Text('Canceled'),
                                  trailing: TextHead(
                                      text:
                                          statusCount['canceled']?.toString() ??
                                              '0'),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
    );
  }

  String _formatCurrency(double value) {
    final formatter = NumberFormat.compact(locale: 'vi');
    return formatter.format(value);
  }

  Widget _buildRevenueChart() {
    // Tìm giá trị max để tính toán scale
    int maxRevenue =
        monthlyStats.map((e) => e.totalRevenue).reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Biểu Đồ Doanh Thu Theo Tháng',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Gap.smHeight,
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxRevenue * 1.2,
                  barGroups: monthlyStats.map((stats) {
                    return BarChartGroupData(
                      x: monthlyStats.indexOf(stats),
                      barRods: [
                        BarChartRodData(
                          toY: double.parse(stats.totalRevenue.toString()),
                          color: Colors.blue.shade400,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        )
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            _formatCurrency(value),
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey.shade700),
                          );
                        },
                        interval: maxRevenue / 3, // chia các số trên trục y
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              monthlyStats[value.toInt()].month,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade700),
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    drawHorizontalLine: true,
                    horizontalInterval: maxRevenue / 3,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyStatsList() {
    return Card(
      elevation: 4,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: monthlyStats.length,
        itemBuilder: (context, index) {
          var stats = monthlyStats[index];
          return ListTile(
            title: Text('Tháng ${stats.month}'),
            subtitle: Text(
                'Tổng doanh thu: ${NumberFormat.currency(locale: 'vi').format(stats.totalRevenue)}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Đặt vé: ${stats.bookingCount}'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCards() {
    int totalRevenue =
        monthlyStats.map((e) => e.totalRevenue).reduce((a, b) => a + b);
    int totalBookings =
        monthlyStats.map((e) => e.bookingCount).reduce((a, b) => a + b);

    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Tổng Doanh Thu',
                      style: Theme.of(context).textTheme.titleSmall),
                  Gap.mdHeight,
                  Text(
                    NumberFormat.currency(locale: 'vi').format(totalRevenue),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Tổng Đặt Vé',
                      style: Theme.of(context).textTheme.titleSmall),
                  Gap.sMHeight,
                  Text(
                    totalBookings.toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
