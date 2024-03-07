import 'package:equatable/equatable.dart';
import 'package:notes/domain/core/typedef/typedefs.dart';

abstract class ValueObject<T> extends Equatable {
  const ValueObject(this.value);

  final Value<T> value;

  @override
  List<Object?> get props => [value];

  bool isValid() => value.isRight();
}
