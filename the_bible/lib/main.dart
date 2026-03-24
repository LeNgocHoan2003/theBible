import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_bible/core/config/env_loader.dart';
import 'package:the_bible/core/di/injection_container.dart';
import 'package:the_bible/core/router/app_router.dart';
import 'package:the_bible/core/theme/app_theme.dart';
import 'package:the_bible/features/auth/domain/usecases/has_valid_session_usecase.dart';
import 'package:the_bible/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvLoader().load();
  await setupDependencies();
  final isAuthenticated = await sl<HasValidSessionUsecase>().call();
  runApp(MyApp(isAuthenticated: isAuthenticated));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isAuthenticated});

  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light(),
      routerConfig: AppRouter.createRouter(isAuthenticated: isAuthenticated),
    );
  }
}
