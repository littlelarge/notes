// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:notes/application/auth/auth_bloc.dart' as _i13;
import 'package:notes/application/auth/sign_in_form/sign_in_form_bloc.dart'
    as _i14;
import 'package:notes/application/notes/note_actor/note_actor_bloc.dart'
    as _i11;
import 'package:notes/application/notes/note_form/note_form_bloc.dart' as _i12;
import 'package:notes/application/notes/note_watcher/note_watcher_bloc.dart'
    as _i10;
import 'package:notes/domain/auth/i_auth_facede.dart' as _i8;
import 'package:notes/domain/notes/i_note_repository.dart' as _i6;
import 'package:notes/infrastructure/auth/firebase_auth_facade.dart' as _i9;
import 'package:notes/infrastructure/core/firebase_injectable_module.dart'
    as _i15;
import 'package:notes/infrastructure/notes/note_repository.dart' as _i7;

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
    gh.lazySingleton<_i3.GoogleSignIn>(
        () => firebaseInjectableModule.googleSignIn);
    gh.lazySingleton<_i4.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i5.FirebaseFirestore>(
        () => firebaseInjectableModule.firestore);
    gh.lazySingleton<_i6.INoteRepository>(
        () => _i7.NoteRepository(gh<_i5.FirebaseFirestore>()));
    gh.lazySingleton<_i8.IAuthFacade>(() => _i9.FirebaseAuthFacede(
          gh<_i4.FirebaseAuth>(),
          gh<_i3.GoogleSignIn>(),
        ));
    gh.factory<_i10.NoteWatcherBloc>(
        () => _i10.NoteWatcherBloc(gh<_i6.INoteRepository>()));
    gh.factory<_i11.NoteActorBloc>(
        () => _i11.NoteActorBloc(gh<_i6.INoteRepository>()));
    gh.factory<_i12.NoteFormBloc>(
        () => _i12.NoteFormBloc(gh<_i6.INoteRepository>()));
    gh.factory<_i13.AuthBloc>(() => _i13.AuthBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i14.SignInFormBloc>(
        () => _i14.SignInFormBloc(gh<_i8.IAuthFacade>()));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i15.FirebaseInjectableModule {}
