import 'package:the_bible/features/home/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.abbrevPt,
    required super.abbrevEn,
    required super.author,
    required super.chapters,
    required super.group,
    required super.name,
    required super.testament,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final abbrev = json['abbrev'] as Map<String, dynamic>? ?? {};

    return BookModel(
      abbrevPt: (abbrev['pt'] as String?) ?? '',
      abbrevEn: (abbrev['en'] as String?) ?? '',
      author: (json['author'] as String?) ?? '',
      chapters: (json['chapters'] as num?)?.toInt() ?? 0,
      group: (json['group'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      testament: (json['testament'] as String?) ?? '',
    );
  }

  factory BookModel.fromEntity(BookEntity entity) {
    return BookModel(
      abbrevPt: entity.abbrevPt,
      abbrevEn: entity.abbrevEn,
      author: entity.author,
      chapters: entity.chapters,
      group: entity.group,
      name: entity.name,
      testament: entity.testament,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abbrev': {
        'pt': abbrevPt,
        'en': abbrevEn,
      },
      'author': author,
      'chapters': chapters,
      'group': group,
      'name': name,
      'testament': testament,
    };
  }
}