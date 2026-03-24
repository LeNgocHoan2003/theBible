import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bible/features/home/domain/usecases/get_book_usecase.dart';
import 'package:the_bible/features/home/presentation/bloc/book_bloc/book_event.dart';
import 'package:the_bible/features/home/presentation/bloc/book_bloc/book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc({
    required GetBookUsecase getBookUsecase,
  }) : _getBookUsecase = getBookUsecase,
       super(const BookState()) {
    on<GetBooksEvent>(_onGetBooks);
  }

  final GetBookUsecase _getBookUsecase;

  void _onGetBooks(GetBooksEvent event, Emitter<BookState> emit) async {
    emit(state.copyWith(status: BookStatus.loading));
    final result = await _getBookUsecase();
    result.fold(
      (failure) => emit(state.copyWith(status: BookStatus.failure, errorMessage: failure.message)),
      (books) => emit(state.copyWith(status: BookStatus.success, books: books)),
    );
  }
}