import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/application/notes/note_form/note_form_bloc.dart';
import 'package:notes/domain/notes/value_objects.dart';
import 'package:notes/presentation/core/colours/colours.dart';
import 'package:notes/presentation/notes/note_form/misc/build_context_x.dart';
import 'package:notes/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.note.todos.isFull != current.note.todos.isFull,
      listener: (context, state) {
        if (state.note.todos.isFull) {
          FlushbarHelper.createAction(
            message: 'Want longer lists? Activate premium 🤩',
            button: TextButton(
              onPressed: () {},
              child: const Text(
                'BUY NOW',
                style: TextStyle(color: Colours.yellow),
              ),
            ),
          ).show(context);
        }
      },
      child: Consumer<FormTodos>(
        builder: (BuildContext context, FormTodos formTodos, Widget? child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: formTodos.value.size,
            itemBuilder: (context, index) {
              return TodoTile(
                key: ValueKey(context.formTodos[index].id),
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}

class TodoTile extends HookWidget {
  const TodoTile({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final todo =
        context.formTodos.getOrElse(index, (_) => TodoItemPrimitive.empty());
    final textEditingController = useTextEditingController(text: todo.name);

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: .2.r,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            label: 'Delete',
            icon: Icons.delete,
            backgroundColor: Colours.red,
            onPressed: (context) {
              context.formTodos = context.formTodos.minusElement(todo);
            },
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colours.grey),
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.r, vertical: 2.r),
        child: ListTile(
          leading: Checkbox(
            value: todo.done,
            onChanged: (value) {
              context.formTodos = context.formTodos.map(
                (listTodo) =>
                    listTodo == todo ? todo.copyWith(done: value!) : listTodo,
              );

              context
                  .read<NoteFormBloc>()
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
          ),
          title: TextFormField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: 'Todo',
              counterText: '',
              border: InputBorder.none,
            ),
            maxLength: TodoName.maxLength,
            onChanged: (value) {
              context.formTodos = context.formTodos.map(
                (listTodo) =>
                    listTodo == todo ? todo.copyWith(name: value) : listTodo,
              );

              context
                  .read<NoteFormBloc>()
                  .add(NoteFormEvent.todosChanged(context.formTodos));
            },
            validator: (_) {
              return context.read<NoteFormBloc>().state.note.todos.value.fold(
                    // Failure stemming from the TodoList length should NOT be
                    // displayed by the individual TextFormFields
                    (f) => null,
                    (todoList) => todoList[index].name.value.fold(
                          (f) => f.maybeWhen(
                            notes: (noteFailure) => noteFailure.maybeMap(
                              empty: (_) => 'Cannot be empty',
                              exceedingLength: (_) => 'Too long',
                              multiline: (_) => 'Has to be in a single line',
                              orElse: () => null,
                            ),
                            orElse: () => null,
                          ),
                          (_) => null,
                        ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
