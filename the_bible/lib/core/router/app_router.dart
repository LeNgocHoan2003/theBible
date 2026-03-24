import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_bible/core/di/injection_container.dart';
import 'package:the_bible/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_bible/features/auth/presentation/screens/auth_screen.dart';
import 'package:the_bible/features/chapter/di/injection.dart';
import 'package:the_bible/features/chapter/presentation/bloc/chapter_bloc.dart';
import 'package:the_bible/features/chapter/presentation/screens/chapter_screen.dart';
import 'package:the_bible/features/home/presentation/bloc/book_bloc/book_bloc.dart';
import 'package:the_bible/features/home/presentation/screens/home_screen.dart';
import 'package:the_bible/features/version/presentation/bloc/version_bloc.dart';

class AppRouter {
  static const String auth = '/';
  static const String home = '/home';
  static const String chapter = '/chapter';

  static GoRouter createRouter({required bool isAuthenticated}) {
    return GoRouter(
      initialLocation: isAuthenticated ? home : auth,
      routes: <RouteBase>[
        GoRoute(
          path: auth,
          builder: (context, state) {
            return BlocProvider<AuthBloc>(
              create: (_) => sl<AuthBloc>(),
              child: const AuthScreen(),
            );
          },
        ),
        GoRoute(
          path: home,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider<BookBloc>(create: (_) => sl<BookBloc>()),
              BlocProvider<VersionBloc>(create: (_) => sl<VersionBloc>()),
            ],
            child: const HomeScreen(),
          ),
        ),
        GoRoute(
          path: chapter,
          builder: (context, state) {
            final version = state.uri.queryParameters['version'] ?? '';
            final abbrev = state.uri.queryParameters['abbrev'] ?? '';
            final name = state.uri.queryParameters['name'] ?? 'Chapter';
            final totalChapters =
                int.tryParse(state.uri.queryParameters['chapters'] ?? '') ?? 1;

            return BlocProvider<ChapterBloc>(
              create: (_) => sl<ChapterBloc>(
                param1: ChapterBlocParams(version: version, abbrev: abbrev),
              ),
              child: ChapterScreen(
                bookName: name,
                totalChapters: totalChapters,
              ),
            );
          },
        ),
      ],
    );
  }
}
