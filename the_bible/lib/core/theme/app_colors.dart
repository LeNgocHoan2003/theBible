import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primaryGold,
    required this.primaryGoldDark,
    required this.accentBlue,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.borderLight,
    required this.iconMuted,
  });

  final Color primaryGold;
  final Color primaryGoldDark;
  final Color accentBlue;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color borderLight;
  final Color iconMuted;

  static const AppColors light = AppColors(
    primaryGold: Color(0xFFC4A22A),
    primaryGoldDark: Color(0xFF8A6E00),
    accentBlue: Color(0xFF4F6F95),
    textPrimary: Color(0xFF1D1D1D),
    textSecondary: Color(0xFF666666),
    textHint: Color(0xFFB0B0B0),
    borderLight: Color(0xFFE8E8E8),
    iconMuted: Color(0xFF6D6D6D),
  );

  @override
  AppColors copyWith({
    Color? primaryGold,
    Color? primaryGoldDark,
    Color? accentBlue,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? borderLight,
    Color? iconMuted,
  }) {
    return AppColors(
      primaryGold: primaryGold ?? this.primaryGold,
      primaryGoldDark: primaryGoldDark ?? this.primaryGoldDark,
      accentBlue: accentBlue ?? this.accentBlue,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      borderLight: borderLight ?? this.borderLight,
      iconMuted: iconMuted ?? this.iconMuted,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primaryGold: Color.lerp(primaryGold, other.primaryGold, t) ?? primaryGold,
      primaryGoldDark:
          Color.lerp(primaryGoldDark, other.primaryGoldDark, t) ??
          primaryGoldDark,
      accentBlue: Color.lerp(accentBlue, other.accentBlue, t) ?? accentBlue,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary:
          Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      textHint: Color.lerp(textHint, other.textHint, t) ?? textHint,
      borderLight: Color.lerp(borderLight, other.borderLight, t) ?? borderLight,
      iconMuted: Color.lerp(iconMuted, other.iconMuted, t) ?? iconMuted,
    );
  }
}
