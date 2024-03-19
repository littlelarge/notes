import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.auth(AuthValueFailure<T> f) = _Auth<T>;
  const factory ValueFailure.notes(NotesValueFailure<T> f) = _Notes<T>;
}

@freezed
sealed class AuthValueFailure<T> with _$AuthValueFailure<T> {
  const factory AuthValueFailure.invalidEmail({required T failedValue}) =
      InvalidEmail<T>;
  const factory AuthValueFailure.shortPassword({required T shortPassword}) =
      ShortPassword<T>;
}

@freezed
sealed class NotesValueFailure<T> with _$NotesValueFailure<T> {
  const factory NotesValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = ExceedingLength<T>;
  const factory NotesValueFailure.empty({required T failedValue}) = _Empty<T>;
  const factory NotesValueFailure.multiline({required T failedValue}) =
      Multiline<T>;
  const factory NotesValueFailure.listTooLong({required T failedValue}) =
      ListTooLong<T>;
}
