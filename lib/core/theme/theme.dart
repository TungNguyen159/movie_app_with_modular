import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_color.dart';

// define name for custom style
const textBodyStyle = 'textBodyStyle';
const textTitleStyle = 'textTitleStyle';
final textBoldStyle =
    TextStyle(color: lightColorScheme.onPrimary, fontWeight: FontWeight.bold);
final textStyle = TextStyle(color: lightColorScheme.onPrimary);

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: lightColorScheme.onPrimary,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: textStyle,
    bodyMedium: textStyle,
    bodySmall: textStyle,
    displayLarge: textStyle,
    displayMedium: textStyle,
    displaySmall: textStyle,
    headlineLarge: textStyle,
    headlineMedium: textStyle,
    headlineSmall: textStyle,
    labelLarge: textStyle,
    labelMedium: textStyle,
    labelSmall: textStyle,
    titleLarge: textStyle,
    titleMedium: textStyle,
    titleSmall: textStyle,
  ),
  iconTheme: IconThemeData(
    color: lightColorScheme.onPrimary,
  ),
  primaryIconTheme: IconThemeData(
    color: lightColorScheme.onPrimary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    iconColor: lightColorScheme.onPrimary,
    suffixIconColor: lightColorScheme.onPrimary,
    prefixIconColor: lightColorScheme.onPrimary,
  ),
  // outlinedButtonTheme: OutlinedButtonThemeData(
  //   style: ButtonStyle(
  //     foregroundColor:
  //         WidgetStatePropertyAll(lightColorScheme.onSecondary),
  //     backgroundColor: WidgetStatePropertyAll(lightColorScheme.onPrimary),
  //     padding: const WidgetStatePropertyAll(
  //       EdgeInsets.symmetric(
  //         vertical: Gap.sM,
  //         horizontal: Gap.lg,
  //       ),
  //     ),
  //     shape: WidgetStatePropertyAll(
  //       RoundedRectangleBorder(
  //         borderRadius: radius8,
  //         side: BorderSide(
  //           color: lightColorScheme.secondary,
  //           width: 1,
  //         ),
  //       ),
  //     ),
  //     textStyle: const WidgetStatePropertyAll(
  //       TextStyle(
  //         fontWeight: FontWeight.w500,
  //         fontSize: 16,
  //       ),
  //     ),
  //   ),
  // ),
);
const textBodyStyle1 = 'textBodyStyle';
const textTitleStyle1 = 'textTitleStyle';
final textBoldStyle1 =
    TextStyle(color: darkColorScheme.onPrimary, fontWeight: FontWeight.bold);
final textStyle1 = TextStyle(color: darkColorScheme.onPrimary);
final dartkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: darkColorScheme.onPrimary,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: textStyle1,
    bodyMedium: textStyle1,
    bodySmall: textStyle1,
    displayLarge: textStyle1,
    displayMedium: textStyle1,
    displaySmall: textStyle1,
    headlineLarge: textStyle1,
    headlineMedium: textStyle1,
    headlineSmall: textStyle1,
    labelLarge: textStyle1,
    labelMedium: textStyle1,
    labelSmall: textStyle1,
    titleLarge: textStyle1,
    titleMedium: textStyle1,
    titleSmall: textStyle1,
  ),
  iconTheme: IconThemeData(
    color: darkColorScheme.onPrimary,
  ),
  primaryIconTheme: IconThemeData(
    color: darkColorScheme.onPrimary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    iconColor: darkColorScheme.onPrimary,
    suffixIconColor: darkColorScheme.onPrimary,
    prefixIconColor: darkColorScheme.onPrimary,
  ),
  // outlinedButtonTheme: OutlinedButtonThemeData(
  //   style: ButtonStyle(
  //     foregroundColor:
  //         WidgetStatePropertyAll(darkColorScheme.onSecondaryContainer),
  //     backgroundColor: WidgetStatePropertyAll(darkColorScheme.onPrimary),
  //     padding: const WidgetStatePropertyAll(
  //       EdgeInsets.symmetric(
  //         vertical: Gap.sM,
  //         horizontal: Gap.lg,
  //       ),
  //     ),
  //     shape: WidgetStatePropertyAll(
  //       RoundedRectangleBorder(
  //         borderRadius: radius8,
  //         side: BorderSide(
  //           color: darkColorScheme.secondary,
  //           width: 1,
  //         ),
  //       ),
  //     ),
  //     textStyle: const WidgetStatePropertyAll(
  //       TextStyle(
  //         fontWeight: FontWeight.w500,
  //         fontSize: 16,
  //       ),
  //     ),
  //   ),
  // ),
);
