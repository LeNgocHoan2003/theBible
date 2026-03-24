import 'package:the_bible/core/utils/typedef.dart';
import 'package:the_bible/features/chapter/domain/entities/chapter_entity.dart';

abstract class ChapterRepository {
  ResultFuture<ChapterEntity> getChapter({
    required String version,
    required String abbrev,
    required int chapter,
  });
}
