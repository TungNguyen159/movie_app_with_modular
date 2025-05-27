import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Function(double, double, double, double) onApplyFilters;

  const FilterBottomSheet({super.key, required this.onApplyFilters});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double minDuration = 30;
  double maxDuration = 180;
  double minRating = 1;
  double maxRating = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Lọc phim", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),

          // Lọc theo thời lượng
          const Text("Thời lượng (phút)"),
          RangeSlider(
            values: RangeValues(minDuration, maxDuration),
            min: 30,
            max: 240,
            divisions: 10,
            labels: RangeLabels(
                "${minDuration.toInt()} min", "${maxDuration.toInt()} min"),
            onChanged: (values) {
              setState(() {
                minDuration = values.start;
                maxDuration = values.end;
              });
            },
          ),

          // Lọc theo điểm đánh giá
          const Text("Điểm đánh giá"),
          RangeSlider(
            values: RangeValues(minRating, maxRating),
            min: 0,
            max: 10,
            divisions: 10,
            labels: RangeLabels(minRating.toString(), maxRating.toString()),
            onChanged: (values) {
              setState(() {
                minRating = values.start;
                maxRating = values.end;
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onApplyFilters(
                  minDuration, maxDuration, minRating, maxRating);
            },
            child: const Text("Áp dụng"),
          )
        ],
      ),
    );
  }
}
