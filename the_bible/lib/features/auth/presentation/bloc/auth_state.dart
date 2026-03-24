import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  const AuthState({
    this.notifications = true,
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  final bool notifications;
  final AuthStatus status;
  final String? errorMessage;

  bool get isSubmitting => status == AuthStatus.loading;

  AuthState copyWith({
    bool? notifications,
    AuthStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return AuthState(
      notifications: notifications ?? this.notifications,
      status: status ?? this.status,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [notifications, status, errorMessage];
}
