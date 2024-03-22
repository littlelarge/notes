// ignore_for_file: invalid_annotation_target

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/domain/core/value_objects.dart';
import 'package:notes/domain/notes/note.dart';
import 'package:notes/domain/notes/todo_item.dart';
import 'package:notes/domain/notes/value_objects.dart';

part 'notes_dto.freezed.dart';
part 'notes_dto.g.dart';

@freezed
abstract class NoteDto implements _$NoteDto {
  const factory NoteDto({
    required String body,
    required int color,
    required List<TodoItemDto> todos,
    @FieldValueConverter() required FieldValue serverTimeStamp,
    @JsonKey(includeFromJson: false) @Default('') String id,
  }) = _NoteDto;

  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);

  factory NoteDto.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    return NoteDto.fromJson(doc.data()).copyWith(id: doc.id);
  }

  const NoteDto._();

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
      id: note.id.getOrCrash(),
      body: note.body.getOrCrash(),
      color: note.color.getOrCrash().value,
      todos: note.todos.getOrCrash().map(TodoItemDto.fromDomain).asList(),
      serverTimeStamp: FieldValue.serverTimestamp(),
    );
  }

  Note toDomain() {
    return Note(
      id: UniqueId.fromUniqueString(id),
      body: NoteBody(body),
      color: NoteColor(Color(color)),
      todos: List3(todos.map((dto) => dto.toDomain()).toImmutableList()),
    );
  }
}

class FieldValueConverter implements JsonConverter<FieldValue, Object> {
  const FieldValueConverter();

  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}

@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  const factory TodoItemDto({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDto;

  const TodoItemDto._();

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);

  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
      id: todoItem.id.getOrCrash(),
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  TodoItem toDomain() {
    return TodoItem(
      id: UniqueId.fromUniqueString(id),
      name: TodoName(name),
      done: done,
    );
  }
}
