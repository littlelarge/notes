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
import 'package:notes/application/auth/bloc/sign_in_form_bloc.dart' as _i5;
import 'package:notes/domain/auth/i_auth_facede.dart' as _i6;
import 'package:notes/infrastructure/auth/firebase_auth_facade.dart' as _i7;
import 'package:notes/infrastructure/core/injectable_module.dart' as _i8;

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
    gh.factory<_i5.SignInFormBloc>(
        () => _i5.SignInFormBloc(gh<_i6.IAuthFacade>()));
    gh.lazySingleton<_i7.FirebaseAuthFacede>(() => _i7.FirebaseAuthFacede(
          gh<_i3.FirebaseAuth>(),
          gh<_i4.GoogleSignIn>(),
        ));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i8.FirebaseInjectableModule {}
