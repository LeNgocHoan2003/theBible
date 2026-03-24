import 'package:equatable/equatable.dart';
import 'package:the_bible/features/chapter/domain/entities/chapter_entity.dart';

enum ChapterStatus { initial, loading, success, failure }

class ChapterState extends Equatable {
  const ChapterState({
    this.status = ChapterStatus.initial,
    this.chapterNumber = 1,
    this.chapterData,
    this.errorMessage,
  });

  final ChapterStatus status;
  final int chapterNumber;
  final ChapterEntity? chapterData;
  final String? errorMessage;

  ChapterState copyWith({
    ChapterStatus? status,
    int? chapterNumber,
    ChapterEntity? chapterData,
    bool clearChapterData = false,
    String? errorMessage,
  }) {
    return ChapterState(
      status: status ?? this.status,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      chapterData: clearChapterData ? null : (chapterData ?? this.chapterData),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, chapterNumber, chapterData, errorMessage];
}
