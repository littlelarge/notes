import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/domain/auth/i_auth_facede.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authFacade) : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        authCheckRequested: (e) async {
          final userOption = await _authFacade.getSignedInUser();

          emit(
            userOption.fold(
              () => const AuthState.unauthenticated(),
              (user) => const AuthState.authenticated(),
            ),
          );
        },
        signedOut: (e) async {
          await _authFacade.signOut();

          emit(const AuthState.unauthenticated());
        },
      );
    });
  }

  final IAuthFacade _authFacade;
}
