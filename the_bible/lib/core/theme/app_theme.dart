import 'package:flutter/material.dart';
import 'package:the_bible/core/theme/app_colors.dart';
import 'package:the_bible/core/theme/app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    const appColors = AppColors.light;
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: appColors.primaryGold,
          brightness: Brightness.light,
        ).copyWith(
          primary: appColors.primaryGoldDark,
          secondary: appColors.accentBlue,
          surface: Colors.white,
        );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      textTheme: AppTextTheme.light(),
      extensions: const <ThemeExtension<dynamic>>[appColors],
    );
  }
}
