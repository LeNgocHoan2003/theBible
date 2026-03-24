import 'package:the_bible/core/usecases/usecase.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/home/domain/entities/book_entity.dart';
import 'package:the_bible/features/home/domain/repositories/book_repository.dart';

class GetBookUsecase extends UsecaseWithoutParams<List<BookEntity>> {
  const GetBookUsecase(this.repository);

  final BookRepository repository;

  @override
  ResultFuture<List<BookEntity>> call() async {
    return repository.getBooks();
  }
}