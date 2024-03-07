import 'package:notes/domain/core/value_objects.dart';
import 'package:notes/domain/core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  factory EmailAddress(String input) =>
      EmailAddress._(validateEmailAddress(input));

  const EmailAddress._(super.value);
}

class Password extends ValueObject<String> {
  factory Password(String input) => Password._(validatePassword(input));

  const Password._(super.value);
}
