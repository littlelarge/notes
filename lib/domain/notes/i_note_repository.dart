import 'package:kt_dart/kt.dart';
import 'package:notes/domain/core/typedef/typedefs.dart';
import 'package:notes/domain/notes/note.dart';

abstract class INoteRepository {
  Stream<RemoteNoteValue<KtList<Note>>> watchAll();
  Stream<RemoteNoteValue<KtList<Note>>> watchUncompleted();
  Future<RemoteNoteRequest> create(Note note);
  Future<RemoteNoteRequest> update(Note note);
  Future<RemoteNoteRequest> delete(Note note);
}
