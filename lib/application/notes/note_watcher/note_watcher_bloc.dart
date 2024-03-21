import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/domain/core/typedef/typedefs.dart';
import 'package:notes/domain/notes/i_note_repository.dart';
import 'package:notes/domain/notes/note.dart';
import 'package:notes/domain/notes/note_failure.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';
part 'note_watcher_bloc.freezed.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  NoteWatcherBloc(this._noteRepository) : super(const _Initial()) {
    on<NoteWatcherEvent>((event, emit) {
      event.map(
        watchAllStarted: (e) {
          emit(const NoteWatcherState.loadInProgress());
          _noteStreamSubscription?.cancel();
          _noteStreamSubscription = _noteRepository.watchAll().listen(
                (failureOrNotes) =>
                    add(NoteWatcherEvent.notesReceived(failureOrNotes)),
              );
        },
        watchUncompletedStarted: (e) {
          emit(const NoteWatcherState.loadInProgress());
          _noteStreamSubscription?.cancel();
          _noteStreamSubscription = _noteRepository.watchUncompleted().listen(
                (failureOrNotes) =>
                    add(NoteWatcherEvent.notesReceived(failureOrNotes)),
              );
        },
        notesReceived: (e) {
          e.failureOrNotes.fold(
            (f) => emit(NoteWatcherState.loadFailure(f)),
            (notes) => emit(NoteWatcherState.loadSuccess(notes)),
          );
        },
      );
    });
  }

  @override
  Future<void> close() async {
    await _noteStreamSubscription?.cancel();
    return super.close();
  }

  final INoteRepository _noteRepository;
  StreamSubscription<RemoteNoteValue>? _noteStreamSubscription;
}
