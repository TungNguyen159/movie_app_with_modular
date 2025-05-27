import 'package:flutter/material.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/core/theme/radius.dart';
import '../../../core/theme/gap.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key, required this.onDateSelected});

  final Function(String) onDateSelected;

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  final List<String> dates = ["Monday 13", "Tuesday 14", "Thursday 15"];
  int? selectedIndex; // Để kiểm tra chưa chọn

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Gap.sM),
      child: Column(
        children: [
          const TextHead(
            text: "Select a date",
          ),
          const SizedBox(height: 10),
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: radius20,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: ListView.builder(
              itemCount: dates.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index; // Cập nhật chỉ mục khi chọn
                    });
                    widget.onDateSelected(dates[index]); // Gọi callback
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(Gap.sm),
                    child: Center(
                      child: buildCategory(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(int index) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: Gap.md, vertical: Gap.sm),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
          style: BorderStyle.solid,
        ),
        borderRadius: radius20,
        color: selectedIndex == index
            ? Theme.of(context).colorScheme.primary
            : Colors.grey.withOpacity(0.2),
      ),
      child: Text(
        dates[index],
        maxLines: 2,
        style: TextStyle(
          fontSize: 16,
          color: selectedIndex == index
              ? Colors.white // Màu chữ khi được chọn
              : Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
