// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFieldApp extends StatelessWidget {
  const TextFieldApp({
    super.key,
    this.hintText,
    this.suffixIcon,
  });
  final String? hintText;
  final Widget? suffixIcon;
 @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        vertical:5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          suffixIconColor: Colors.white,
          hintStyle:const TextStyle(
            color:Colors.black,
          ),
        ),
      ),
    );
  }
}
