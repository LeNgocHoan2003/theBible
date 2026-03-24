import 'package:dio/dio.dart';
import 'package:the_bible/core/di/injection_container.dart';
import 'package:the_bible/features/home/data/datasources/book_datasource.dart';
import 'package:the_bible/features/home/data/repositories/book_repository_implement.dart';
import 'package:the_bible/features/home/domain/repositories/book_repository.dart';
import 'package:the_bible/features/home/domain/usecases/get_book_usecase.dart';
import 'package:the_bible/features/home/presentation/bloc/book_bloc/book_bloc.dart';

class HomeInjection {
  static void init() {
    sl.registerLazySingleton<BookDatasource>(
      () => BookDatasourceImpl(dio: sl<Dio>()),
    );

    sl.registerLazySingleton<BookRepository>(
      () => BookRepositoryImplement(datasource: sl<BookDatasource>()),
    );

    sl.registerLazySingleton<GetBookUsecase>(
      () => GetBookUsecase(sl<BookRepository>()),
    );

    sl.registerFactory<BookBloc>(
      () => BookBloc(getBookUsecase: sl<GetBookUsecase>()),
    );
  }
}