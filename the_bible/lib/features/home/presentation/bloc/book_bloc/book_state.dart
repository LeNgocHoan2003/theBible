import 'package:equatable/equatable.dart';
import 'package:the_bible/features/home/domain/entities/book_entity.dart';
  
enum BookStatus { initial, loading, success, failure }

class BookState extends Equatable {
  const BookState({
    this.books = const [],
    this.status = BookStatus.initial,
    this.errorMessage,
  });

  final List<BookEntity> books;
  final BookStatus status;
  final String? errorMessage;

  BookState copyWith({
    List<BookEntity>? books,
    BookStatus? status,
    String? errorMessage,
  }) {
    return BookState(
      books: books ?? this.books,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [books, status, errorMessage];
}