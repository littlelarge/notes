import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/application/notes/note_form/note_form_bloc.dart';
import 'package:notes/presentation/notes/note_form/misc/build_context_x.dart';
import 'package:notes/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.isEditting != current.isEditting,
      listener: (context, state) {
        context.formTodos = state.note.todos.value.fold(
          (f) => listOf<TodoItemPrimitive>(),
          (todoItemList) => todoItemList.map(
            TodoItemPrimitive.fromDomain,
          ),
        );
      },
      buildWhen: (previous, current) =>
          previous.note.todos.isFull != current.note.todos.isFull,
      builder: (context, state) {
        return ListTile(
          enabled: !state.note.todos.isFull,
          title: const Text('Add a todo'),
          leading: Padding(
            padding: EdgeInsets.all(12.r),
            child: const Icon(Icons.add),
          ),
          onTap: () {
            context.formTodos =
                context.formTodos.plusElement(TodoItemPrimitive.empty());

            context.read<NoteFormBloc>().add(
                  NoteFormEvent.todosChanged(
                    context.formTodos,
                  ),
                );
          },
        );
      },
    );
  }
}
