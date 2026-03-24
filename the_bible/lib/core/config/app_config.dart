import 'package:flutter/foundation.dart';
import 'package:the_bible/core/config/config_keys.dart';
import 'package:the_bible/core/config/env_loader.dart';

class AppConfig {
  final String baseUrl;
  final bool enableLog;

  AppConfig({
    required this.baseUrl,
    required this.enableLog,
  });

  factory AppConfig.fromEnv(EnvLoader envLoader) {
    return AppConfig(
      baseUrl: envLoader.getString(ConfigKeys.baseUrl),
      enableLog: envLoader.getBool(
        ConfigKeys.enableLog,
        defaultValue: kDebugMode,
      ),
    );
  }
}

