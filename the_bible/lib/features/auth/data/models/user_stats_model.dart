import 'package:the_bible/features/auth/domain/entities/user_stats.dart';

class UserStatsModel extends UserStats {
  const UserStatsModel({
    required super.lastLogin,
    required super.requestsPerMonth,
  });

  factory UserStatsModel.fromJson(Map<String, dynamic> json) {
    final raw = json['requestsPerMonth'] as List<dynamic>? ?? [];
    return UserStatsModel(
      lastLogin: _parseLastLogin(json['lastLogin']),
      requestsPerMonth: raw
          .map((e) => e as Map<String, dynamic>)
          .map(
            (e) => MonthlyRequestTotal(
              range: e['range'] as String,
              total: (e['total'] as num).toInt(),
            ),
          )
          .toList(),
    );
  }

  static DateTime? _parseLastLogin(Object? value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
