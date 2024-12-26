import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Colors.blue, // Màu  nổi bật
  onPrimary: Colors.white, // Màu chữ trên primary
  secondary: Color(0xFFFDD835), // Màu vàng (nhấn mạnh các nút)
  onSecondary: Colors.black, // Màu chữ trên secondary
  surface: Color(0xFFFFFFFF), // Màu nền cho Card, Dialog
  onSurface: Color(0xFF000000), // Màu chữ trên surface
  error: Color(0xFFD32F2F), // Màu cho thông báo lỗi
  onError: Colors.white, // Màu chữ trên màu error
  secondaryContainer: Color(0xFF97FB57),
  onSecondaryContainer: Color.fromARGB(255, 0, 0, 0),
);

const darkColorScheme = ColorScheme(
  primary: Color(0x0000193a),
  secondary: Color(0xFF4D1F7C),
  //  background: Color(0xFF241E30),
  surface: Color(0xFF1F1929), // màu nền chính
  // onBackground: Color(0x0DFFFFFF),
  error: Colors.redAccent,
  onError: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  brightness: Brightness.dark,
  onSecondaryContainer: Colors.white,
);
