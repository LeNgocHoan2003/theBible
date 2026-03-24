import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bible/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:the_bible/features/auth/domain/usecases/update_token_usecase.dart';
import 'package:the_bible/features/auth/presentation/bloc/auth_event.dart';
import 'package:the_bible/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required CreateUserUsecase createUserUsecase,
    required UpdateTokenUsecase updateTokenUsecase,
  }) : _createUserUsecase = createUserUsecase,
       _updateTokenUsecase = updateTokenUsecase,
       super(const AuthState()) {
    on<AuthNotificationsToggled>(_onNotificationsToggled);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthSignUpSubmitted>(_onSignUpSubmitted);
    on<AuthFeedbackCleared>(_onFeedbackCleared);
  }

  final CreateUserUsecase _createUserUsecase;
  final UpdateTokenUsecase _updateTokenUsecase;

  void _onNotificationsToggled(
    AuthNotificationsToggled event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(notifications: event.value));
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearErrorMessage: true));
    final result = await _updateTokenUsecase(event.params);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: AuthStatus.success)),
    );
  }

  Future<void> _onSignUpSubmitted(
    AuthSignUpSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading, clearErrorMessage: true));
    final result = await _createUserUsecase(event.params);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: AuthStatus.success)),
    );
  }

  void _onFeedbackCleared(AuthFeedbackCleared event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.initial, clearErrorMessage: true));
  }
}
