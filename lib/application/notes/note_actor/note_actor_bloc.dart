import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/domain/notes/i_note_repository.dart';
import 'package:notes/domain/notes/note.dart';
import 'package:notes/domain/notes/note_failure.dart';

part 'note_actor_event.dart';
part 'note_actor_state.dart';
part 'note_actor_bloc.freezed.dart';

@injectable
class NoteActorBloc extends Bloc<NoteActorEvent, NoteActorState> {
  NoteActorBloc(this._noteRepository) : super(const _Initial()) {
    on<NoteActorEvent>((event, emit) {
      event.map(
        deleted: (e) async {
          emit(const NoteActorState.actionInProgress());
          final possibleFailure = await _noteRepository.delete(e.note);
          emit(
            possibleFailure.fold(
              NoteActorState.deleteFailure,
              (_) => const NoteActorState.deleteSuccess(),
            ),
          );
        },
      );
    });
  }

  final INoteRepository _noteRepository;
}
