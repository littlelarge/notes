import 'package:notes/domain/core/typedef/typedefs.dart';
import 'package:notes/domain/notes/note.dart';

abstract class INoteRepository {
  Stream<RemoteNoteValue> watchAll();
  Stream<RemoteNoteValue> watchUncompleted();
  Future<RemoteNoteRequest> create(Note note);
  Future<RemoteNoteRequest> update(Note note);
  Future<RemoteNoteRequest> delete(Note note);
}
