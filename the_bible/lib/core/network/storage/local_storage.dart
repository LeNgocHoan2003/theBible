import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();

  Future<void> saveUserEmail(String email);
  Future<String?> getUserEmail();
  Future<void> clearUserEmail();
}

class SharedPrefsImpl implements LocalStorage {
  SharedPrefsImpl({required this.prefs});

  final SharedPreferences prefs;

  @override
  Future<void> saveToken(String token) async {
    await prefs.setString('token', token);
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString('token');
  }

  @override
  Future<void> clearToken() async {
    await prefs.remove('token');
  }

  @override
  Future<void> saveUserEmail(String email) async {
    await prefs.setString('user_email', email);
  }

  @override
  Future<String?> getUserEmail() async {
    return prefs.getString('user_email');
  }

  @override
  Future<void> clearUserEmail() async {
    await prefs.remove('user_email');
  }
}