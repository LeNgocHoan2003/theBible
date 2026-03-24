class CreateUserParams {
  const CreateUserParams({
    required this.email,
    required this.password,
    required this.name,
    required this.notifications,
  });

  final String email;
  final String password;
  final String name;
  final bool notifications;
}