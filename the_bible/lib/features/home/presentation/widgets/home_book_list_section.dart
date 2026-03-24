import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bible/features/home/domain/entities/book_entity.dart';
import 'package:the_bible/features/home/presentation/bloc/book_bloc/book_bloc.dart';
import 'package:the_bible/features/home/presentation/bloc/book_bloc/book_state.dart';

class HomeBookListSection extends StatelessWidget {
  const HomeBookListSection({required this.onBookSelected, super.key});

  final ValueChanged<BookEntity> onBookSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state.status == BookStatus.loading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == BookStatus.failure) {
          return SliverToBoxAdapter(
            child: Center(child: Text(state.errorMessage ?? '')),
          );
        }

        if (state.status == BookStatus.success) {
          final books = state.books;

          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final book = books[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => onBookSelected(book),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Text('Author: ${book.author}'),
                        Text('Chapters: ${book.chapters}'),
                        Text('Group: ${book.group}'),
                        Text('Testament: ${book.testament}'),
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: books.length),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
