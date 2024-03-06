import 'package:dartz/dartz.dart';
import 'package:notes/domain/core/failures.dart';

typedef Value<T> = Either<ValueFailure<T>, T>;
