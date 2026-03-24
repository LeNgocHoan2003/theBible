import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:the_bible/core/errors/failure.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:the_bible/features/chapter/data/datasources/chapter_datasource.dart';
import 'package:the_bible/features/chapter/domain/entities/chapter_entity.dart';
import 'package:the_bible/features/chapter/domain/repositories/chapter_repository.dart';

class ChapterRepositoryImpl extends ChapterRepository {
  ChapterRepositoryImpl({required this.datasource});

  final ChapterDatasource datasource;

  @override
  ResultFuture<ChapterEntity> getChapter({
    required String version,
    required String abbrev,
    required int chapter,
  }) async {
    try {
      final data = await datasource.getChapter(
        version: version,
        abbrev: abbrev,
        chapter: chapter,
      );
      return Right(data);
    } on DioException catch (e) {
      return Left(mapDioToFailure(e));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 0));
    }
  }
}
