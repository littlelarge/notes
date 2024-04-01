part of 'sign_in_form_bloc.dart';

@freezed

/// [isSubmiting] is used to indicate should be shown circular indicator
///
/// [showErrorMessages] is used to indicate whether errors should be shown
/// if they exist in [ValueObject]s
///
/// [authFailureOrSuccess] is used to ensure that there are no errors 
/// when you first enter the login page
///
class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    required EmailAddress emailAddress,
    required Password password,
    required AutovalidateMode showErrorMessages,
    required bool isSubmiting,
    required AuthOptionResult authFailureOrSuccess,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
        emailAddress: EmailAddress(''),
        password: Password(''),
        showErrorMessages: AutovalidateMode.disabled,
        isSubmiting: false,
        authFailureOrSuccess: none(),
      );
}
