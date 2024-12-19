import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(left: 8.0, right: 16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(79, 249, 249, 249),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        focusNode: focusNode,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.white),
          prefixIconConstraints: BoxConstraints(minWidth: 28.0),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Color.fromARGB(79, 249, 249, 249),
          ),
        ),
      ),
    );
  }
}
