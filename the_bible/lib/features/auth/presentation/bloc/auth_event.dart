import 'package:equatable/equatable.dart';
import 'package:the_bible/features/auth/domain/params/create_user_params.dart';
import 'package:the_bible/features/auth/domain/params/update_token_params.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthNotificationsToggled extends AuthEvent {
  const AuthNotificationsToggled(this.value);

  final bool value;

  @override
  List<Object?> get props => [value];
}

class AuthLoginSubmitted extends AuthEvent {
  const AuthLoginSubmitted(this.params);

  final UpdateTokenParams params;

  @override
  List<Object?> get props => [params];
}

class AuthSignUpSubmitted extends AuthEvent {
  const AuthSignUpSubmitted(this.params);

  final CreateUserParams params;

  @override
  List<Object?> get props => [params];
}

class AuthFeedbackCleared extends AuthEvent {
  const AuthFeedbackCleared();
}
