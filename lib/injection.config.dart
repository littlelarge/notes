// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:notes/application/auth/auth_bloc.dart' as _i11;
import 'package:notes/application/auth/sign_in_form/sign_in_form_bloc.dart'
    as _i10;
import 'package:notes/application/notes/note_actor/note_actor_bloc.dart' as _i7;
import 'package:notes/application/notes/note_watcher/note_watcher_bloc.dart'
    as _i9;
import 'package:notes/domain/auth/i_auth_facede.dart' as _i5;
import 'package:notes/domain/notes/i_note_repository.dart' as _i8;
import 'package:notes/infrastructure/auth/firebase_auth_facade.dart' as _i6;
import 'package:notes/infrastructure/core/injectable_module.dart' as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.lazySingleton<_i3.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i4.GoogleSignIn>(
        () => firebaseInjectableModule.googleSignIn);
    gh.lazySingleton<_i5.IAuthFacade>(() => _i6.FirebaseAuthFacede(
          gh<_i3.FirebaseAuth>(),
          gh<_i4.GoogleSignIn>(),
        ));
    gh.factory<_i7.NoteActorBloc>(
        () => _i7.NoteActorBloc(gh<_i8.INoteRepository>()));
    gh.factory<_i9.NoteWatcherBloc>(
        () => _i9.NoteWatcherBloc(gh<_i8.INoteRepository>()));
    gh.factory<_i10.SignInFormBloc>(
        () => _i10.SignInFormBloc(gh<_i5.IAuthFacade>()));
    gh.factory<_i11.AuthBloc>(() => _i11.AuthBloc(gh<_i5.IAuthFacade>()));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i12.FirebaseInjectableModule {}
