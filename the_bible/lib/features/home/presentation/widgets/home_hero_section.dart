import 'package:flutter/material.dart';
import 'package:the_bible/core/theme/app_colors.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({
    required this.welcomeBack,
    required this.title,
    required this.searchPlaceholder,
    super.key,
  });

  final String welcomeBack;
  final String title;
  final String searchPlaceholder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            welcomeBack,
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.accentBlue,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 48,
              height: 1.1,
              fontWeight: FontWeight.w800,
              color: appColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: appColors.borderLight),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          alignment: Alignment.centerLeft,
          child: Text(
            searchPlaceholder,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.textHint,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
