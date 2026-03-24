class BookEntity {
  const BookEntity({
    required this.abbrevPt,
    required this.abbrevEn,
    required this.author,
    required this.chapters,
    required this.group,
    required this.name,
    required this.testament,
  });

  final String abbrevPt;
  final String abbrevEn;
  final String author;
  final int chapters;
  final String group;
  final String name;
  final String testament;

  factory BookEntity.fromJson(Map<String, dynamic> json) {
    final abbrev = (json['abbrev'] as Map<String, dynamic>?) ?? {};

    return BookEntity(
      abbrevPt: (abbrev['pt'] ?? '') as String,
      abbrevEn: (abbrev['en'] ?? '') as String,
      author: (json['author'] ?? '') as String,
      chapters: (json['chapters'] ?? 0) as int,
      group: (json['group'] ?? '') as String,
      name: (json['name'] ?? '') as String,
      testament: (json['testament'] ?? '') as String,
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