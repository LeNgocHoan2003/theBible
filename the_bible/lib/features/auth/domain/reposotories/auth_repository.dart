import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/auth/domain/entities/user_entity.dart';
import 'package:the_bible/features/auth/domain/entities/user_stats.dart';
import 'package:the_bible/features/auth/domain/params/create_user_params.dart';
import 'package:the_bible/features/auth/domain/params/delete_user_params.dart';
import 'package:the_bible/features/auth/domain/params/resend_password_params.dart';
import 'package:the_bible/features/auth/domain/params/update_token_params.dart';

abstract class AuthRepository {
  Future<bool> hasValidSession();
  ResultFuture<UserEntity> createUser(CreateUserParams params);
  ResultFuture<UserEntity> getUser();
  ResultFuture<UserStats> getUserStats();
  ResultFuture<UserEntity> upDateToken(UpdateTokenParams params);
  ResultVoid deleteUser(DeleteUserParams params);
  ResultVoid resendUserPassword(ResendPasswordParams params);
}
