import 'package:dartz/dartz.dart';
import 'package:notes/domain/auth/auth_failure.dart';
import 'package:notes/domain/core/failures.dart';

typedef Value<T> = Either<ValueFailure<T>, T>;

typedef AuthResult = Either<AuthFailure, Unit>;

typedef AuthOptionResult = Option<AuthResult>;
