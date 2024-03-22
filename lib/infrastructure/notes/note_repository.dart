import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/domain/core/typedef/typedefs.dart';
import 'package:notes/domain/notes/i_note_repository.dart';
import 'package:notes/domain/notes/note.dart';
import 'package:notes/domain/notes/note_failure.dart';
import 'package:notes/infrastructure/core/firestore_helpers.dart';
import 'package:notes/infrastructure/notes/notes_dto.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: INoteRepository)
class NoteRepository implements INoteRepository {
  NoteRepository(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<RemoteNoteValue> watchAll() async* {
    final userDoc = await _firestore.userDocument();

    yield* userDoc.noteCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => right<NoteFailure, KtList<Note>>(
            snapshot.docs.map((doc) {
              NoteDto.fromFirestore(
                doc as QueryDocumentSnapshot<Map<String, dynamic>>,
              ).toDomain();
            }).toImmutableList() as KtList<Note>,
          ),
        )
        .onErrorReturnWith((e, stackTrace) {
      if (e is PlatformException && e.message!.contains('ACCESS_DENIED')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        return left(const NoteFailure.unexpected());
      }
    });
  }

  @override
  Stream<RemoteNoteValue> watchUncompleted() async* {
    final userDoc = await _firestore.userDocument();

    yield* userDoc.noteCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            NoteDto.fromFirestore(
              doc as QueryDocumentSnapshot<Map<String, dynamic>>,
            ).toDomain();
          }).whereType<Note>(),
        )
        .map(
          (notes) => right<NoteFailure, KtList<Note>>(
            notes
                .where(
                  (note) =>
                      note.todos.getOrCrash().any((todoItem) => !todoItem.done),
                )
                .toImmutableList(),
          ),
        )
        .onErrorReturnWith((e, stackTrace) {
      if (e is PlatformException && e.message!.contains('ACCESS_DENIED')) {
        return left(const NoteFailure.insufficientPermission());
      } else {
        return left(const NoteFailure.unexpected());
      }
    });
  }

  @override
  Future<RemoteNoteRequest> create(Note note) {
    // TODO(littlelarge): implement create
    throw UnimplementedError();
  }

  @override
  Future<RemoteNoteRequest> delete(Note note) {
    // TODO(littlelarge): implement delete
    throw UnimplementedError();
  }

  @override
  Future<RemoteNoteRequest> update(Note note) {
    // TODO(littlelarge): implement update
    throw UnimplementedError();
  }
}
