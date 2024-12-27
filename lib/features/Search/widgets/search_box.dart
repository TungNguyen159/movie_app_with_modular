import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/gap.dart';
import 'package:movie_app/core/theme/radius.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    this.controller,
    this.onChanged,
    this.focusNode,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: Gap.sm, right: Gap.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        //color: const Color.fromARGB(79, 249, 249, 249),
        borderRadius: radius20,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        focusNode: focusNode,
        style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onTertiary,
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: Gap.lX),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onTertiary,
          ),
        ),
      ),
    );
  }
}
