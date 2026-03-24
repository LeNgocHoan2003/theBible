import 'package:equatable/equatable.dart';
import 'package:the_bible/core/usecases/usecase.dart';
import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/chapter/domain/entities/chapter_entity.dart';
import 'package:the_bible/features/chapter/domain/repositories/chapter_repository.dart';

class GetChapterUsecase extends UsecaseWithParams<ChapterEntity, GetChapterParams> {
  const GetChapterUsecase(this._repository);

  final ChapterRepository _repository;

  @override
  ResultFuture<ChapterEntity> call(GetChapterParams params) {
    return _repository.getChapter(
      version: params.version,
      abbrev: params.abbrev,
      chapter: params.chapter,
    );
  }
}

class GetChapterParams extends Equatable {
  const GetChapterParams({
    required this.version,
    required this.abbrev,
    required this.chapter,
  });

  final String version;
  final String abbrev;
  final int chapter;

  @override
  List<Object?> get props => [version, abbrev, chapter];
}
