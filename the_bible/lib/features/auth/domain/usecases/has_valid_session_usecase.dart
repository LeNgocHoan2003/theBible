import 'package:the_bible/features/auth/domain/reposotories/auth_repository.dart';

class HasValidSessionUsecase {
  const HasValidSessionUsecase(this.repository);

  final AuthRepository repository;

  Future<bool> call() {
    return repository.hasValidSession();
  }
}
