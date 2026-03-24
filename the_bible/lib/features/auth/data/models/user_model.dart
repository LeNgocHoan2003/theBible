import 'package:the_bible/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.email,
    required super.token,
    required super.notifications,
    super.lastLogin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      notifications: json['notifications'] as bool? ?? false,
      lastLogin: _parseLastLogin(json['lastLogin']),
    );
  }

  static DateTime? _parseLastLogin(Object? value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
