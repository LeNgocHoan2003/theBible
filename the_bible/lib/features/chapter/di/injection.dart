import 'package:dio/dio.dart';
import 'package:the_bible/core/di/injection_container.dart';
import 'package:the_bible/features/chapter/data/datasources/chapter_datasource.dart';
import 'package:the_bible/features/chapter/data/repositories/chapter_repository_impl.dart';
import 'package:the_bible/features/chapter/domain/repositories/chapter_repository.dart';
import 'package:the_bible/features/chapter/domain/usecases/get_chapter_usecase.dart';
import 'package:the_bible/features/chapter/presentation/bloc/chapter_bloc.dart';

class ChapterInjection {
  static void init() {
    sl.registerLazySingleton<ChapterDatasource>(
      () => ChapterDatasourceImpl(dio: sl<Dio>()),
    );
    sl.registerLazySingleton<ChapterRepository>(
      () => ChapterRepositoryImpl(datasource: sl<ChapterDatasource>()),
    );
    sl.registerLazySingleton<GetChapterUsecase>(
      () => GetChapterUsecase(sl<ChapterRepository>()),
    );
    sl.registerFactoryParam<ChapterBloc, ChapterBlocParams, void>(
      (params, _) => ChapterBloc(
        getChapterUsecase: sl<GetChapterUsecase>(),
        version: params.version,
        abbrev: params.abbrev,
      ),
    );
  }
}

class ChapterBlocParams {
  const ChapterBlocParams({
    required this.version,
    required this.abbrev,
  });

  final String version;
  final String abbrev;
}
