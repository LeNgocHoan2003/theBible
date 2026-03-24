import 'package:flutter/material.dart';
import 'package:the_bible/core/theme/app_colors.dart';

class HomeAppBarRow extends StatelessWidget {
  const HomeAppBarRow({
    required this.title,
    required this.logoutLabel,
    required this.onLogout,
    super.key,
  });

  final String title;
  final String logoutLabel;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: appColors.iconMuted,
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 30,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
              color: appColors.textPrimary,
            ),
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'logout') {
              onLogout();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(value: 'logout', child: Text(logoutLabel)),
          ],
          icon: Icon(
            Icons.account_circle_outlined,
            color: appColors.primaryGoldDark,
          ),
        ),
      ],
    );
  }
}
