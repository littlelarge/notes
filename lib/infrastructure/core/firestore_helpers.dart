import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/domain/auth/i_auth_facede.dart';
import 'package:notes/domain/core/errors/errors.dart.dart';
import 'package:notes/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = await getIt<IAuthFacade>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    return getIt<FirebaseFirestore>()
        .collection('users')
        .doc(user.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
