part of 'note_form_bloc.dart';

@freezed
abstract class NoteFormState with _$NoteFormState {
  const factory NoteFormState({
    required Note note,
    required AutovalidateMode showErrorMessages,
    required bool isEditting,
    required bool isSaving, // to showing progress
    required Option<RemoteNoteRequest> saveFailureOrSuccessOption,
  }) = _NoteFormState;

  factory NoteFormState.initial() => NoteFormState(
        note: Note.empty(),
        showErrorMessages: AutovalidateMode.disabled,
        isEditting: false,
        isSaving: false,
        saveFailureOrSuccessOption: none(),
      );
}
