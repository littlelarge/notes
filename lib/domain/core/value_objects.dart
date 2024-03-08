import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/domain/core/errors/errors.dart.dart';
import 'package:notes/domain/core/errors/failures.dart';
import 'package:notes/domain/core/typedef/typedefs.dart';

abstract class ValueObject<T> extends Equatable {
  const ValueObject(this.value);

  final Value<T> value;

  @override
  List<Object?> get props => [value];

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    return value.fold(
      (f) => throw UnexpectedValueError(f),
      id,
    );
  }

  bool isValid() => value.isRight();
}
