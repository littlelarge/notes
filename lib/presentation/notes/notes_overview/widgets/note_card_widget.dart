import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/application/notes/note_actor/note_actor_bloc.dart';
import 'package:notes/domain/notes/note.dart';
import 'package:notes/domain/notes/todo_item.dart';
import 'package:notes/presentation/core/colours/colours.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    required this.note,
    super.key,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.color.getOrCrash(),
      child: InkWell(
        onTap: () {
          // TODO(littlelarge): Implement navigation
        },
        onLongPress: () {
          final noteActorBloc = context.read<NoteActorBloc>();

          _showDeletionDialog(context, noteActorBloc);
        },
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.body.getOrCrash(),
                style: TextStyle(fontSize: 18.r),
              ),
              if (note.todos.length > 0) ...[
                SizedBox(height: 4.r),
                Wrap(
                  spacing: 8.r,
                  children: [
                    ...note.todos
                        .getOrCrash()
                        .map((todoItem) => TodoDisplay(todoItem: todoItem))
                        .iter,
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showDeletionDialog(BuildContext context, NoteActorBloc noteActorBloc) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selected note:'),
          content: Text(
            note.body.getOrCrash(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                noteActorBloc.add(NoteActorEvent.deleted(note));

                context.pop();
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }
}

class TodoDisplay extends StatelessWidget {
  const TodoDisplay({required this.todoItem, super.key});

  final TodoItem todoItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (todoItem.done)
          const Icon(
            Icons.check_box_rounded,
            color: Colours.primary,
          )
        else
          Icon(
            Icons.check_box_outline_blank_rounded,
            color: Theme.of(context).disabledColor,
          ),
        SizedBox(
          width: 2.r,
        ),
        Text(todoItem.name.getOrCrash()),
      ],
    );
  }
}
