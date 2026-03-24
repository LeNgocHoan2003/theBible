import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:the_bible/core/errors/failure.dart';
import 'package:the_bible/core/network/storage/local_storage.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:the_bible/features/auth/data/services/token_validator.dart';
import 'package:the_bible/features/auth/domain/entities/user_entity.dart';
import 'package:the_bible/features/auth/domain/entities/user_stats.dart';
import 'package:the_bible/features/auth/domain/params/create_user_params.dart';
import 'package:the_bible/features/auth/domain/params/delete_user_params.dart';
import 'package:the_bible/features/auth/domain/params/resend_password_params.dart';
import 'package:the_bible/features/auth/domain/params/update_token_params.dart';
import 'package:the_bible/features/auth/domain/reposotories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
  });

  final AuthRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;

  @override
  Future<bool> hasValidSession() async {
    final token = await localStorage.getToken();
    if (token == null || token.isEmpty) return false;

    final expired = TokenValidator.isExpired(token);
    if (expired) {
      await localStorage.clearToken();
      await localStorage.clearUserEmail();
      return false;
    }

    return true;
  }

  @override
  ResultFuture<UserEntity> createUser(CreateUserParams params) async {
    try {
      final user = await remoteDataSource.createUser(params);
      await localStorage.saveToken(user.token);
      await localStorage.saveUserEmail(user.email);
      return Right(user);
    } on DioException catch (e) {
      return Left(mapDioToFailure(e));
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString(), statusCode: 0),
      );
    }
  }

  @override
  ResultFuture<UserEntity> getUser() async {
    try {
      final email = await localStorage.getUserEmail();
      if (email == null || email.isEmpty) {
        return const Left(
          ApiFailure(message: 'No saved user email', statusCode: 401),
        );
      }
      final user = await remoteDataSource.getUser(email);
      await localStorage.saveToken(user.token);
      await localStorage.saveUserEmail(user.email);
      return Right(user);
    } on DioException catch (e) {
      return Left(mapDioToFailure(e));
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString(), statusCode: 0),
      );
    }
  }

  @override
  ResultFuture<UserStats> getUserStats() async {
    try {
      final stats = await remoteDataSource.getUserStats();
      return Right(stats);
    } on DioException catch (e) {
      return Left(mapDioToFailure(e));
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString(), statusCode: 0),
      );
    }
  }

  @override
  ResultFuture<UserEntity> upDateToken(UpdateTokenParams params) async {
    try {
      final user = await remoteDataSource.updateToken(params);
      await localStorage.saveToken(user.token);
      await localStorage.saveUserEmail(user.email);
      return Right(user);
    } on DioException catch (e) {
      return Left(mapDioToFailure(e));
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString(), statusCode: 0),
      );
    }
  }

  @override
  ResultVoid deleteUser(DeleteUserParams params) async {
    try {
      await remoteDataSource.deleteUser(params);
      await localStorage.clearToken();
      await localStorage.clearUserEmail();
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioToFailure(e));
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString(), statusCode: 0),
      );
    }
  }

  @override
  ResultVoid resendUserPassword(ResendPasswordParams params) async {
    try {
      await remoteDataSource.resendPassword(params.email);
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioToFailure(e));
    } catch (e) {
      return Left(
        ApiFailure(message: e.toString(), statusCode: 0),
      );
    }
  }
}

Failure mapDioToFailure(DioException e) {
  final status = e.response?.statusCode ?? 0;
  final data = e.response?.data;
  var message = e.message ?? 'Request failed';
  if (data is Map) {
    final msg = data['msg'] ?? data['message'];
    if (msg != null) {
      message = msg.toString();
    }
  }
  return ApiFailure(message: message, statusCode: status);
}
