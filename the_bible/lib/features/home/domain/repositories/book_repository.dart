import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/home/domain/entities/book_entity.dart';

abstract class BookRepository {
  ResultFuture<List<BookEntity>> getBooks();
}