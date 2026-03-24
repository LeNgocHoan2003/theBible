import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bible/features/chapter/presentation/bloc/chapter_bloc.dart';
import 'package:the_bible/features/chapter/presentation/bloc/chapter_event.dart';
import 'package:the_bible/features/chapter/presentation/bloc/chapter_state.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({
    required this.bookName,
    required this.totalChapters,
    super.key,
  });

  final String bookName;
  final int totalChapters;

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChapterBloc>().add(const LoadChapterEvent(1));
  }

  @override
  Widget build(BuildContext context) {
    final chapterItems = List<int>.generate(widget.totalChapters, (index) => index + 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<ChapterBloc, ChapterState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<int>(
                  value: state.chapterNumber,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Chapter',
                  ),
                  items: chapterItems
                      .map(
                        (chapter) => DropdownMenuItem<int>(
                          value: chapter,
                          child: Text('Chapter $chapter'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    context.read<ChapterBloc>().add(LoadChapterEvent(value));
                  },
                ),
                const SizedBox(height: 16),
                if (state.status == ChapterStatus.loading)
                  const Expanded(child: Center(child: CircularProgressIndicator())),
                if (state.status == ChapterStatus.failure)
                  Expanded(
                    child: Center(
                      child: Text(
                        state.errorMessage ?? 'Unable to load chapter',
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  ),
                if (state.status == ChapterStatus.success && state.chapterData != null)
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.chapterData!.verses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final verse = state.chapterData!.verses[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  TextSpan(
                                    text: '${verse.number} ',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: verse.text),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
