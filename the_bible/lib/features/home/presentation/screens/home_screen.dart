import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_bible/core/di/injection_container.dart';
import 'package:the_bible/core/network/storage/local_storage.dart';
import 'package:the_bible/core/router/app_router.dart';
import 'package:the_bible/features/home/domain/entities/book_entity.dart';
import 'package:the_bible/features/home/presentation/bloc/book_bloc/book_bloc.dart';
import 'package:the_bible/features/home/presentation/bloc/book_bloc/book_event.dart';
import 'package:the_bible/features/home/presentation/widgets/home_app_bar_row.dart';
import 'package:the_bible/features/home/presentation/widgets/home_book_list_section.dart';
import 'package:the_bible/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:the_bible/features/home/presentation/widgets/home_hero_section.dart';
import 'package:the_bible/features/version/presentation/bloc/version_bloc.dart';
import 'package:the_bible/features/version/presentation/bloc/version_event.dart';
import 'package:the_bible/features/version/presentation/screens/version_screen.dart';
import 'package:the_bible/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _logout(BuildContext context) async {
    await sl<LocalStorage>().clearToken();
    await sl<LocalStorage>().clearUserEmail();
    if (!context.mounted) return;
    context.go(AppRouter.auth);
  }

  void _getBooks(BuildContext context) {
    context.read<BookBloc>().add(GetBooksEvent());
  }

  void _getVersions(BuildContext context) {
    context.read<VersionBloc>().add(GetVersionsEvent());
  }

  Future<void> _goToChapters(
    BuildContext context,
    BookEntity book,
  ) async {
    final selectedVersion = context.read<VersionBloc>().state.selectedVersion;
    if (selectedVersion == null || selectedVersion.isEmpty) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a version first')),
      );
      return;
    }

    final encodedVersion = Uri.encodeComponent(selectedVersion);
    final encodedAbbrev = Uri.encodeComponent(book.abbrevPt);
    final encodedBookName = Uri.encodeComponent(book.name);
    context.push(
      '${AppRouter.chapter}?version=$encodedVersion&abbrev=$encodedAbbrev&name=$encodedBookName&chapters=${book.chapters}',
    );
  }

  @override
  void initState() {
    super.initState();
    _getBooks(context);
    _getVersions(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HomeAppBarRow(
                      title: l10n.homeTitle,
                      logoutLabel: l10n.logoutAction,
                      onLogout: () => _logout(context),
                    ),
                    const SizedBox(height: 24),
                    // HomeHeroSection(
                    //   welcomeBack: l10n.welcomeBack,
                    //   title: l10n.homeHeroTitle,
                    //   searchPlaceholder: l10n.searchPlaceholder,
                    // ),
                    const SizedBox(height: 24),
                    VersionSection(
                      recommendedForYou: l10n.recommendedForYou,
                      defaultTitle: l10n.recommendedVersionTitle,
                      subtitle: l10n.recommendedVersionSubtitle,
                      readNowLabel: l10n.readNow,
                      detailsLabel: l10n.detailsAction,
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
              HomeBookListSection(
                onBookSelected: (book) {
                  _goToChapters(context, book);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNavBar(
        homeNavTitle: l10n.homeNavTitle,
        homeNavSubtitle: l10n.homeNavSubtitle,
        libraryNavTitle: l10n.libraryNavTitle,
        searchNavTitle: l10n.searchNavTitle,
      ),
    );
  }
}
