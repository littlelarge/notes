import 'package:dartz/dartz.dart';
import 'package:notes/domain/auth/user.dart';
import 'package:notes/domain/auth/value_objects.dart';
import 'package:notes/domain/core/typedef/typedefs.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();
  Future<AuthResult> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<AuthResult> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<AuthResult> signInWithGoogle();
  Future<void> signOut();
}
