import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvLoader {
  Future<void> load({String fileName = '.env.dev'}) async {
    await dotenv.load(fileName: fileName);
  }

  String getString(String key, {String defaultValue = ''}) {
    return dotenv.env[key] ?? defaultValue;
  }

  bool getBool(String key, {bool defaultValue = false}) {
    final rawValue = dotenv.env[key];
    if (rawValue == null || rawValue.isEmpty) {
      return defaultValue;
    }
    return rawValue.toLowerCase() == 'true';
  }
}
