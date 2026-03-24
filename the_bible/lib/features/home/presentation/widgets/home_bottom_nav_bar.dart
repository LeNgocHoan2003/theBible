import 'package:flutter/material.dart';
import 'package:the_bible/core/theme/app_colors.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    required this.homeNavTitle,
    required this.homeNavSubtitle,
    required this.libraryNavTitle,
    required this.searchNavTitle,
    super.key,
  });

  final String homeNavTitle;
  final String homeNavSubtitle;
  final String libraryNavTitle;
  final String searchNavTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: appColors.primaryGold,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BottomNavItem(
            icon: Icons.home_filled,
            title: homeNavTitle,
            subtitle: homeNavSubtitle,
          ),
          _BottomNavItem(icon: Icons.menu_book_rounded, title: libraryNavTitle),
          _BottomNavItem(icon: Icons.search_rounded, title: searchNavTitle),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: appColors.primaryGoldDark),
        const SizedBox(height: 2),
        Text(
          title,
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.primaryGoldDark,
            fontWeight: FontWeight.w700,
            fontSize: 11,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: theme.textTheme.labelMedium?.copyWith(
              color: appColors.primaryGoldDark,
              fontWeight: FontWeight.w600,
              fontSize: 9,
            ),
          ),
      ],
    );
  }
}
