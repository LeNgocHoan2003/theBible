import 'package:equatable/equatable.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object?> get props => [];
}

class GetBooksEvent extends BookEvent {
  const GetBooksEvent();
}