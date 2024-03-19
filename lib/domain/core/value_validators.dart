import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/domain/core/errors/failures.dart';
import 'package:notes/domain/core/typedef/typedefs.dart';

Value<String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.notes(
        NotesValueFailure.exceedingLength(
          failedValue: input,
          max: maxLength,
        ),
      ),
    );
  }
}

Value<String> validateStringNotEmpty(String input) {
  if (input.isNotEmpty) {
    return right(input);
  } else {
    return left(
      ValueFailure.notes(NotesValueFailure.empty(failedValue: input)),
    );
  }
}

Value<String> validateSingleLine(String input) {
  if (!input.contains('\n')) {
    return right(input);
  } else {
    return left(
      ValueFailure.notes(NotesValueFailure.multiline(failedValue: input)),
    );
  }
}

Value<KtList<T>> validateMaxListLength<T>(
  KtList<T> input,
  int maxLength,
) {
  if (input.size <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.notes(
        NotesValueFailure.listTooLong(
          failedValue: input,
          max: maxLength,
        ),
      ),
    );
  }
}

Value<String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(
      ValueFailure.auth(
        AuthValueFailure.invalidEmail(failedValue: input),
      ),
    );
  }
}

Value<String> validatePassword(String input) {
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(
      ValueFailure.auth(
        AuthValueFailure.shortPassword(shortPassword: input),
      ),
    );
  }
}
