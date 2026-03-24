/// Domain model for an authenticated user (A Bíblia Digital API).
class UserEntity {
  const UserEntity({
    required this.name,
    required this.email,
    required this.token,
    required this.notifications,
    this.lastLogin,
  });

  final String name;
  final String email;
  final String token;
  final bool notifications;
  final DateTime? lastLogin;
}
