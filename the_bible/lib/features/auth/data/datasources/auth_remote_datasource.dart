import 'package:dio/dio.dart';

import 'package:the_bible/features/auth/data/models/user_model.dart';
import 'package:the_bible/features/auth/data/models/user_stats_model.dart';
import 'package:the_bible/features/auth/domain/params/create_user_params.dart';
import 'package:the_bible/features/auth/domain/params/delete_user_params.dart';
import 'package:the_bible/features/auth/domain/params/update_token_params.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> createUser(CreateUserParams params);

  Future<UserModel> getUser(String email);

  Future<UserStatsModel> getUserStats();

  Future<UserModel> updateToken(UpdateTokenParams params);

  Future<void> deleteUser(DeleteUserParams params);

  Future<void> resendPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  static const _usersPath = '/api/users';

  @override
  Future<UserModel> createUser(CreateUserParams params) async {
    final response = await dio.post<Map<String, dynamic>>(
      _usersPath,
      data: <String, dynamic>{
        'name': params.name,
        'email': params.email,
        'password': params.password,
        'notifications': params.notifications,
      },
    );
    return UserModel.fromJson(response.data!);
  }

  @override
  Future<UserModel> getUser(String email) async {
    final response = await dio.get<Map<String, dynamic>>(
      '$_usersPath/${Uri.encodeComponent(email)}',
    );
    return UserModel.fromJson(response.data!);
  }

  @override
  Future<UserStatsModel> getUserStats() async {
    final response = await dio.get<Map<String, dynamic>>(
      '$_usersPath/stats',
    );
    return UserStatsModel.fromJson(response.data!);
  }

  @override
  Future<UserModel> updateToken(UpdateTokenParams params) async {
    final response = await dio.put<Map<String, dynamic>>(
      '$_usersPath/token',
      data: <String, dynamic>{
        'email': params.email,
        'password': params.password,
      },
    );
    return UserModel.fromJson(response.data!);
  }

  @override
  Future<void> deleteUser(DeleteUserParams params) async {
    await dio.delete<void>(
      _usersPath,
      data: <String, dynamic>{
        'email': params.email,
        'password': params.password,
      },
    );
  }

  @override
  Future<void> resendPassword(String email) async {
    await dio.post<void>(
      '$_usersPath/password/${Uri.encodeComponent(email)}',
    );
  }
}
