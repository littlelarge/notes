import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/domain/core/typedef/typedefs.dart';
import 'package:notes/domain/notes/i_note_repository.dart';
import 'package:notes/domain/notes/note.dart';
import 'package:notes/domain/notes/note_failure.dart';
import 'package:notes/domain/notes/value_objects.dart';
import 'package:notes/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';
part 'note_form_bloc.freezed.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  NoteFormBloc(this._noteRepository) : super(NoteFormState.initial()) {
    on<NoteFormEvent>((event, emit) async {
      await event.map(
        initialized: (e) {
          emit(
            e.initialNoteOption.fold(
              () => state,
              (initialNote) =>
                  state.copyWith(note: initialNote, isEditting: true),
            ),
          );
        },
        bodyChanged: (e) {
          emit(
            state.copyWith(
              note: state.note.copyWith(body: NoteBody(e.bodyStr)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        colorChanged: (e) {
          emit(
            state.copyWith(
              note: state.note.copyWith(color: NoteColor(e.color)),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        todosChanged: (e) {
          emit(
            state.copyWith(
              note: state.note.copyWith(
                todos: List3(e.todos.map((primitive) => primitive.toDomain())),
              ),
              saveFailureOrSuccessOption: none(),
            ),
          );
        },
        saved: (e) async {
          RemoteNoteRequest? failureOrSuccess;

          emit(
            state.copyWith(
              isSaving: true,
              saveFailureOrSuccessOption: none(),
            ),
          );

          if (state.note.failureOption.isNone()) {
            failureOrSuccess = state.isEditting
                ? await _noteRepository.update(state.note)
                : await _noteRepository.create(state.note);
          }

          emit(
            state.copyWith(
              isSaving: false,
              showErrorMessages: AutovalidateMode.always,
              saveFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }

  final INoteRepository _noteRepository;
}
