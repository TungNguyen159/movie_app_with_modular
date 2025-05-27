import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.blue, // Màu  nổi bật
  onPrimary: Colors.black, // Màu chữ trên primary
  secondary: Colors.blue, // Màu nút nhấn
  onSecondary: Colors.white, // Màu chữ nút nhấn
  surface: Color(0xFFe6e6e6), // Màu chinh
  onSurface: Color(0xFF000000), // Màu chữ trên surface
  error: Color(0xFFD32F2F), // Màu cho thông báo lỗi
  onError: Colors.white, // Màu chữ trên màu error
  // secondaryContainer: Color.fromARGB(255, 117, 91, 121),
  // onSecondaryContainer: Color.fromARGB(255, 0, 0, 0),
  tertiary: Color.fromARGB(198, 129, 129, 129), // màu của search box
  onTertiary: Colors.white, // màu của search box
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.blue,
  onPrimary: Colors.white,
  secondary: Colors.blue,
  onSecondary: Colors.black,
  surface: Color(0xFF1F1929), // màu nền chính
  onSurface: Colors.white, //màu chữ trên nền chính
  error: Colors.redAccent,
  onError: Colors.white,
  secondaryContainer: Color.fromARGB(255, 117, 91, 121),
  onSecondaryContainer: Colors.white,
  tertiary: Color.fromARGB(198, 129, 129, 129), // màu của search box
  onTertiary: Colors.white, // màu của search box
);
