import 'package:the_bible/core/usecases/usecase.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/auth/domain/params/delete_user_params.dart';
import 'package:the_bible/features/auth/domain/reposotories/auth_repository.dart';

class DeleteUserUsecase extends UsecaseWithParams<void, DeleteUserParams> {
  const DeleteUserUsecase(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<void> call(DeleteUserParams params) async {
    return repository.deleteUser(params);
  }
}
