/// Domain model for user statistics (A Bíblia Digital API `GET /api/users/stats`).
class UserStats {
  const UserStats({
    required this.lastLogin,
    required this.requestsPerMonth,
  });

  final DateTime? lastLogin;
  final List<MonthlyRequestTotal> requestsPerMonth;
}

/// One row in `requestsPerMonth` (e.g. range `01/2020`, total requests in that month).
class MonthlyRequestTotal {
  const MonthlyRequestTotal({
    required this.range,
    required this.total,
  });

  final String range;
  final int total;
}
