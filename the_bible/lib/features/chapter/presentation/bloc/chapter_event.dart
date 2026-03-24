import 'package:equatable/equatable.dart';

abstract class ChapterEvent extends Equatable {
  const ChapterEvent();

  @override
  List<Object?> get props => [];
}

class LoadChapterEvent extends ChapterEvent {
  const LoadChapterEvent(this.chapterNumber);

  final int chapterNumber;

  @override
  List<Object?> get props => [chapterNumber];
}
