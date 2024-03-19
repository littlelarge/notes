import 'package:dartz/dartz.dart';
import 'package:notes/domain/core/errors/failures.dart';
import 'package:notes/domain/core/typedef/typedefs.dart';

Value<String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  if (RegExp(emailRegex).hasMatch(input)) {
    return Right(input);
  } else {
    return Left(ValueFailure.auth(InvalidEmail(failedValue: input)));
  }
}

Value<String> validatePassword(String input) {
  if (input.length >= 6) {
    return Right(input);
  } else {
    return Left(ValueFailure.auth(ShortPassword(shortPassword: input)));
  }
}
