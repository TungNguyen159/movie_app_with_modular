import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/app_color.dart';
import 'package:movie_app/core/theme/gap.dart';
import 'package:movie_app/core/theme/radius.dart';

// define name for custom style
const textBodyStyle = 'textBodyStyle';
const textTitleStyle = 'textTitleStyle';
final textBoldStyle = TextStyle(
    color: lightColorScheme.onSecondaryContainer, fontWeight: FontWeight.bold);
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
    color: lightColorScheme.secondary,
  ),
  primaryIconTheme: IconThemeData(
    color: lightColorScheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    iconColor: lightColorScheme.secondary,
    suffixIconColor: lightColorScheme.secondary,
    prefixIconColor: lightColorScheme.secondary,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          WidgetStatePropertyAll(lightColorScheme.onSecondaryContainer),
      backgroundColor: WidgetStatePropertyAll(lightColorScheme.onPrimary),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: Gap.sM,
          horizontal: Gap.lg,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: radius8,
          side: BorderSide(
            color: lightColorScheme.secondary,
            width: 1,
          ),
        ),
      ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  ),
);

final dartkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: darkColorScheme.onSecondaryContainer,
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
    color: darkColorScheme.primary,
  ),
  primaryIconTheme: IconThemeData(
    color: darkColorScheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    iconColor: darkColorScheme.secondary,
    suffixIconColor: darkColorScheme.secondary,
    prefixIconColor: darkColorScheme.secondary,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          WidgetStatePropertyAll(darkColorScheme.onSecondaryContainer),
      backgroundColor: WidgetStatePropertyAll(darkColorScheme.onPrimary),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(
          vertical: Gap.sM,
          horizontal: Gap.lg,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: radius8,
          side: BorderSide(
            color: darkColorScheme.secondary,
            width: 1,
          ),
        ),
      ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    ),
  ),
);
