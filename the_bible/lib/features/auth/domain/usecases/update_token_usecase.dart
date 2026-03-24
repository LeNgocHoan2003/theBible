import 'package:the_bible/core/usecases/usecase.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/auth/domain/entities/user_entity.dart';
import 'package:the_bible/features/auth/domain/params/update_token_params.dart';
import 'package:the_bible/features/auth/domain/reposotories/auth_repository.dart';

class UpdateTokenUsecase extends UsecaseWithParams<UserEntity, UpdateTokenParams> {
  const UpdateTokenUsecase(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<UserEntity> call(UpdateTokenParams params) async {
    return repository.upDateToken(params);
  }
}
