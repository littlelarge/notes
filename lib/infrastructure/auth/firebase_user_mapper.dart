import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/domain/auth/user.dart' as u;
import 'package:notes/domain/core/value_objects.dart';

extension FirebaseUserDomainX on User {
  u.User toDomain() {
    return u.User(id: UniqueId.fromUniqueString(uid));
  }
}
