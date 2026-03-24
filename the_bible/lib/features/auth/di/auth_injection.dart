import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:the_bible/core/network/storage/local_storage.dart';
import 'package:the_bible/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:the_bible/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:the_bible/features/auth/domain/reposotories/auth_repository.dart';
import 'package:the_bible/features/auth/domain/usecases/create_user_usecase.dart';
import 'package:the_bible/features/auth/domain/usecases/has_valid_session_usecase.dart';
import 'package:the_bible/features/auth/domain/usecases/update_token_usecase.dart';
import 'package:the_bible/features/auth/presentation/bloc/auth_bloc.dart';

void initAuthDependencies(GetIt sl) {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localStorage: sl<LocalStorage>(),
    ),
  );

  sl.registerLazySingleton<CreateUserUsecase>(
    () => CreateUserUsecase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<HasValidSessionUsecase>(
    () => HasValidSessionUsecase(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<UpdateTokenUsecase>(
    () => UpdateTokenUsecase(sl<AuthRepository>()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      createUserUsecase: sl<CreateUserUsecase>(),
      updateTokenUsecase: sl<UpdateTokenUsecase>(),
    ),
  );
}
