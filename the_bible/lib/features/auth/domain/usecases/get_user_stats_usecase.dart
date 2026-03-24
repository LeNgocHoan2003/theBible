import 'package:the_bible/core/usecases/usecase.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/auth/domain/entities/user_stats.dart';
import 'package:the_bible/features/auth/domain/reposotories/auth_repository.dart';

class GetUserStatsUsecase extends UsecaseWithoutParams<UserStats> {
  const GetUserStatsUsecase(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<UserStats> call() async {
    return repository.getUserStats();
  }
}
