import 'package:dio/dio.dart';
import 'package:the_bible/features/chapter/data/models/chapter_model.dart';

abstract class ChapterDatasource {
  Future<ChapterModel> getChapter({
    required String version,
    required String abbrev,
    required int chapter,
  });
}

class ChapterDatasourceImpl implements ChapterDatasource {
  ChapterDatasourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<ChapterModel> getChapter({
    required String version,
    required String abbrev,
    required int chapter,
  }) async {
    final path = '/api/verses/$version/$abbrev/$chapter';
    final response = await dio.get<Map<String, dynamic>>(path);
    return ChapterModel.fromJson(response.data ?? const {});
  }
}
