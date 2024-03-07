import 'package:notes/domain/auth/value_objects.dart';
import 'package:notes/domain/core/typedefs.dart';

abstract class IAuthFacade {
  Future<AuthResult> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<AuthResult> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<AuthResult> signInWithGoogle();
}
