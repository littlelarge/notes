// ignore_for_file: inference_failure_on_function_invocation

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/domain/core/errors/failures.dart';
import 'package:notes/domain/core/value_objects.dart';
import 'package:notes/domain/notes/todo_item.dart';
import 'package:notes/domain/notes/value_objects.dart';

part 'note.freezed.dart';

@freezed
abstract class Note implements _$Note {
  const factory Note({
    required UniqueId id,
    required NoteBody body,
    required NoteColor color,
    required List3<TodoItem> todos,
  }) = _Note;

  const Note._();

  factory Note.empty() => Note(
        id: UniqueId(),
        body: NoteBody(''),
        color: NoteColor(NoteColor.predefinedColors[0]),
        todos: List3(emptyList()),
      );

  Option<ValueFailure<dynamic>> get failureOption {
    return body.failureOrUnit
        .andThen(todos.failureOrUnit)
        .andThen(
          todos
              .getOrCrash()
              // Getting the failureOption from the TodoItem 
              // ENTITY - NOT a failureOrUnit from a VALUE
              .map((todoItem) => todoItem.failureOption)
              .filter((todoItem) => todoItem.isSome())
              // If we can't get the 0th element,
              // the list is empty. In such a case,
              // it's valid
              .getOrElse(0, (_) => none())
              .fold(() => right(unit), left),
        )
        .fold(some, (r) => none());
  }
}
