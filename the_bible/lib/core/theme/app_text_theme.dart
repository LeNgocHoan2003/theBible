import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme light() {
    return const TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        fontSize: 48,
        height: 1.1,
        fontWeight: FontWeight.w800,
      ),
      headlineSmall: TextStyle(
        fontSize: 52,
        height: 1.05,
        fontWeight: FontWeight.w800,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        height: 1.35,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(letterSpacing: 1.1, fontWeight: FontWeight.w700),
      labelLarge: TextStyle(fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontWeight: FontWeight.w700),
    );
  }
}
