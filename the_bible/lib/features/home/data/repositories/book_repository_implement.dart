import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:the_bible/core/errors/failure.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:the_bible/features/home/data/datasources/book_datasource.dart';
import 'package:the_bible/features/home/domain/entities/book_entity.dart';
import 'package:the_bible/features/home/domain/repositories/book_repository.dart';

class BookRepositoryImplement extends BookRepository {
  BookRepositoryImplement({required this.datasource});

  final BookDatasource datasource;

  @override
  ResultFuture<List<BookEntity>> getBooks() async {
    try {
      final books = await datasource.getBooks();
      return Right(books);
    } on DioException catch (e) {
      return Left(mapDioToFailure(e));
    } catch (e) {
      return Left(ApiFailure(message: e.toString(), statusCode: 0));
    }
  }
}