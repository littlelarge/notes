import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/domain/notes/note.dart';

class ErrorNoteCard extends StatelessWidget {
  const ErrorNoteCard({required this.note, super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.error,
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            Text(
              'Invalid note. Please, contact support',
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 18.r),
            ),
            SizedBox(height: 2.r),
            Text(
              'Details for nerds:',
              style: Theme.of(context).primaryTextTheme.bodyLarge,
            ),
            Text(
              note.failureOption.fold(() => '', (f) => f.toString()),
              style: Theme.of(context).primaryTextTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
