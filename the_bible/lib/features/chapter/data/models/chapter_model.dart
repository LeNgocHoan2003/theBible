import 'package:the_bible/features/chapter/domain/entities/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  const ChapterModel({
    required super.book,
    required super.chapter,
    required super.verses,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    final bookJson = (json['book'] as Map<String, dynamic>?) ?? {};
    final chapterJson = (json['chapter'] as Map<String, dynamic>?) ?? {};
    final abbrevJson = (bookJson['abbrev'] as Map<String, dynamic>?) ?? {};
    final versesJson = (json['verses'] as List<dynamic>?) ?? const [];

    return ChapterModel(
      book: ChapterBookEntity(
        abbrevPt: (abbrevJson['pt'] as String?) ?? '',
        abbrevEn: (abbrevJson['en'] as String?) ?? '',
        name: (bookJson['name'] as String?) ?? '',
        author: (bookJson['author'] as String?) ?? '',
        group: (bookJson['group'] as String?) ?? '',
        version: (bookJson['version'] as String?) ?? '',
      ),
      chapter: ChapterInfoEntity(
        number: (chapterJson['number'] as num?)?.toInt() ?? 0,
        verses: (chapterJson['verses'] as num?)?.toInt() ?? 0,
      ),
      verses: versesJson
          .whereType<Map<String, dynamic>>()
          .map(
            (item) => ChapterVerseEntity(
              number: (item['number'] as num?)?.toInt() ?? 0,
              text: (item['text'] as String?) ?? '',
            ),
          )
          .toList(growable: false),
    );
  }
}
