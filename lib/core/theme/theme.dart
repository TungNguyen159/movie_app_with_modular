import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_color.dart';

// define name for custom style
const textBodyStyle = 'textBodyStyle';
const textTitleStyle = 'textTitleStyle';
const textBoldStyle = 'textBoldStyle';
final textStyle = TextStyle(color: lightColorScheme.onSecondaryContainer);



final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: lightColorScheme.onSecondaryContainer,
    ),
    shape: LinearBorder.bottom(
      side: BorderSide(
        width: 1,
        color: lightColorScheme.primary,
      ),
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
    color: lightColorScheme.primary,
  ),
  primaryIconTheme: IconThemeData(
    color: lightColorScheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    iconColor: lightColorScheme.primary,
    suffixIconColor: lightColorScheme.primary,
    prefixIconColor: lightColorScheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(lightColorScheme.onPrimary),
      backgroundColor: WidgetStatePropertyAll(lightColorScheme.primary),
      // padding: const WidgetStatePropertyAll(
      //   EdgeInsets.symmetric(
      //     vertical: Gap.sM,
      //     horizontal: Gap.lg,
      //   ),
      // ),
      // shape: WidgetStatePropertyAll(
      //   RoundedRectangleBorder(
      //     borderRadius: radius8,
      //   ),
      // ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          WidgetStatePropertyAll(lightColorScheme.onSecondaryContainer),
      backgroundColor: WidgetStatePropertyAll(lightColorScheme.onPrimary),
      // padding: const WidgetStatePropertyAll(
      //   EdgeInsets.symmetric(
      //     vertical: Gap.sM,
      //     horizontal: Gap.lg,
      //   ),
      // ),
      // shape: WidgetStatePropertyAll(
      //   RoundedRectangleBorder(
      //     borderRadius: radius8,
      //     side: BorderSide(
      //       color: lightColorScheme.secondary,
      //       width: 1,
      //     ),
      //   ),
      // ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  ),
  // extensions: [
  //   CustomStyle(
  //     name: textBodyStyle,
  //     style: TextStyle(
  //       color: lightColorScheme.onSecondaryContainer,
  //       fontSize: 14,
  //     ),
  //   ),
  //   CustomStyle(
  //     name: textTitleStyle,
  //     style: TextStyle(
  //         color: lightColorScheme.onSecondaryContainer,
  //         fontSize: 14,
  //         fontWeight: FontWeight.w500),
  //   ),
  //   CustomStyle(
  //     name: textBoldStyle,
  //     style: TextStyle(
  //       color: lightColorScheme.onSecondaryContainer,
  //       fontSize: 14,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  // ],
);

final dartkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  // extensions: [
  //   CustomStyle(
  //     name: textBodyStyle,
  //     style: TextStyle(
  //       color: darkColorScheme.onSecondaryContainer,
  //       fontSize: 14,
  //     ),
  //   ),
  //   CustomStyle(
  //     name: textTitleStyle,
  //     style: TextStyle(
  //       color: darkColorScheme.onSecondaryContainer,
  //       fontSize: 14,
  //       fontWeight: FontWeight.w500,
  //     ),
  //   ),
  //   CustomStyle(
  //     name: textBoldStyle,
  //     style: TextStyle(
  //       color: darkColorScheme.onSecondaryContainer,
  //       fontSize: 14,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  // ],
);
