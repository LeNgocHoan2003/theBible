import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bible/features/chapter/domain/usecases/get_chapter_usecase.dart';
import 'package:the_bible/features/chapter/presentation/bloc/chapter_event.dart';
import 'package:the_bible/features/chapter/presentation/bloc/chapter_state.dart';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  ChapterBloc({
    required GetChapterUsecase getChapterUsecase,
    required String version,
    required String abbrev,
  }) : _getChapterUsecase = getChapterUsecase,
       _version = version,
       _abbrev = abbrev,
       super(const ChapterState()) {
    on<LoadChapterEvent>(_onLoadChapter);
  }

  final GetChapterUsecase _getChapterUsecase;
  final String _version;
  final String _abbrev;

  void _onLoadChapter(LoadChapterEvent event, Emitter<ChapterState> emit) async {
    emit(
      state.copyWith(
        status: ChapterStatus.loading,
        chapterNumber: event.chapterNumber,
      ),
    );
    final result = await _getChapterUsecase(
      GetChapterParams(
        version: _version,
        abbrev: _abbrev,
        chapter: event.chapterNumber,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: ChapterStatus.failure, errorMessage: failure.message),
      ),
      (chapter) => emit(
        state.copyWith(
          status: ChapterStatus.success,
          chapterData: chapter,
          chapterNumber: chapter.chapter.number,
        ),
      ),
    );
  }
}
