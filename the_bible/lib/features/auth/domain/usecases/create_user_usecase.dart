import 'package:the_bible/core/usecases/usecase.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/auth/domain/entities/user_entity.dart';
import 'package:the_bible/features/auth/domain/params/create_user_params.dart';
import 'package:the_bible/features/auth/domain/reposotories/auth_repository.dart';

class CreateUserUsecase extends UsecaseWithParams<UserEntity, CreateUserParams> {
  const CreateUserUsecase(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<UserEntity> call(CreateUserParams params) async {
    return repository.createUser(params);
  }
}