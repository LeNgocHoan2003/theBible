import 'package:flutter/material.dart';
import 'package:the_bible/core/theme/app_colors.dart';

class HomeRecommendedCard extends StatelessWidget {
  const HomeRecommendedCard({
    required this.recommendedForYou,
    required this.title,
    required this.subtitle,
    required this.readNowLabel,
    required this.detailsLabel,
    super.key,
  });

  final String recommendedForYou;
  final String title;
  final String subtitle;
  final String readNowLabel;
  final String detailsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 420),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: appColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recommendedForYou,
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.accentBlue,
              letterSpacing: 1.1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: 52,
              height: 1.05,
              fontWeight: FontWeight.w800,
              color: appColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.textSecondary,
              fontSize: 18,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: appColors.primaryGoldDark,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  readNowLabel,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Text(
                detailsLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: appColors.primaryGoldDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
