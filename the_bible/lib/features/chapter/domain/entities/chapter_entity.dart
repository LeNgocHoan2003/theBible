class ChapterEntity {
  const ChapterEntity({
    required this.book,
    required this.chapter,
    required this.verses,
  });

  final ChapterBookEntity book;
  final ChapterInfoEntity chapter;
  final List<ChapterVerseEntity> verses;
}

class ChapterBookEntity {
  const ChapterBookEntity({
    required this.abbrevPt,
    required this.abbrevEn,
    required this.name,
    required this.author,
    required this.group,
    required this.version,
  });

  final String abbrevPt;
  final String abbrevEn;
  final String name;
  final String author;
  final String group;
  final String version;
}

class ChapterInfoEntity {
  const ChapterInfoEntity({
    required this.number,
    required this.verses,
  });

  final int number;
  final int verses;
}

class ChapterVerseEntity {
  const ChapterVerseEntity({
    required this.number,
    required this.text,
  });

  final int number;
  final String text;
}
