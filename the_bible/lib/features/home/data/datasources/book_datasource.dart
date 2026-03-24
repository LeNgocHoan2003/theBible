import 'package:dio/dio.dart';
import 'package:the_bible/core/network/dio_json_extensions.dart';
import 'package:the_bible/features/home/data/models/book_model.dart';

abstract class BookDatasource {
  Future<List<BookModel>> getBooks();
}

class BookDatasourceImpl implements BookDatasource {
  BookDatasourceImpl({required this.dio});

  final Dio dio;

  static const _booksPath = '/api/books';

  @override
  Future<List<BookModel>> getBooks() async {
    return dio.getList(_booksPath, fromJson: BookModel.fromJson);
  }
}