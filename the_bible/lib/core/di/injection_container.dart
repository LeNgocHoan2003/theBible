import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_bible/core/config/app_config.dart';
import 'package:the_bible/core/config/env_loader.dart';
import 'package:the_bible/core/network/interceptors/auth_interceptor.dart';
import 'package:the_bible/core/network/storage/local_storage.dart';
import 'package:the_bible/features/auth/di/auth_injection.dart';
import 'package:the_bible/features/chapter/di/injection.dart';
import 'package:the_bible/features/home/di/injection.dart';
import 'package:the_bible/features/version/di/injection.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  sl.registerLazySingleton<EnvLoader>(() => EnvLoader());
  sl.registerLazySingleton<AppConfig>(
    () => AppConfig.fromEnv(sl<EnvLoader>()),
  );

  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<LocalStorage>(
    () => SharedPrefsImpl(prefs: sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(localStorage: sl<LocalStorage>()),
  );

  sl.registerLazySingleton<Dio>(() {
    final appConfig = sl<AppConfig>();
    final dio = Dio(
      BaseOptions(
        baseUrl: appConfig.baseUrl,
        headers: <String, dynamic>{'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(sl<AuthInterceptor>());
    if (appConfig.enableLog) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
        ),
      );
    }
    return dio;
  });

  initAuthDependencies(sl);
  HomeInjection.init();
  ChapterInjection.init();
  VersionInjection.init();
}
