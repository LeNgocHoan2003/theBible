import 'package:the_bible/core/usecases/usecase.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/auth/domain/params/resend_password_params.dart';
import 'package:the_bible/features/auth/domain/reposotories/auth_repository.dart';

class ResendUserPasswordUsecase
    extends UsecaseWithParams<void, ResendPasswordParams> {
  const ResendUserPasswordUsecase(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<void> call(ResendPasswordParams params) async {
    return repository.resendUserPassword(params);
  }
}
