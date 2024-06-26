import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/domain/auth/auth_failure.dart';
import 'package:notes/domain/core/errors/failures.dart';
import 'package:notes/domain/notes/note.dart';
import 'package:notes/domain/notes/note_failure.dart';

typedef Value<T> = Either<ValueFailure<T>, T>;

typedef RemoteNoteValue = Either<NoteFailure, KtList<Note>>;

typedef RemoteNoteRequest = Either<NoteFailure, Unit>;

typedef AuthResult = Either<AuthFailure, Unit>;

typedef AuthOptionResult = Option<AuthResult>;
