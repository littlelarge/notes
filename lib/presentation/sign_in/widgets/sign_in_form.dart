// ignore_for_file: inference_failure_on_instance_creation

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:notes/presentation/core/assets/assets.dart';
import 'package:notes/presentation/core/colours/colours.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccess.fold(() {}, (either) {
          either.fold(
            (f) {
              Flushbar(
                message: f.map(
                  cancelledByUser: (_) => 'Cancelled',
                  serverError: (_) => 'Server error',
                  emailAlreadyInUse: (_) => 'Email already in use',
                  invalidEmailAndPasswordCombination: (_) =>
                      'Invalid email and password combination',
                ),
                backgroundColor: Colours.errorColor,
              ).show(context);
            },
            (r) {
              // TODO(littlelarge): Navigation
            },
          );
        });
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showErrorMessages,
          child: Flexible(
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.notes,
                  height: 130.r,
                ),
                Text('Sign in', style: TextStyle(fontSize: 40.r)),
                SizedBox(height: 10.r),
                SizedBox(
                  width: 400.r,
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: const Text('Email'),
                      prefixIcon: Icon(
                        Icons.email,
                        size: 24.r,
                      ),
                    ),
                    autocorrect: false,
                    onChanged: (value) => context
                        .read<SignInFormBloc>()
                        .add(SignInFormEvent.emailChanged(value)),
                    validator: (_) => context
                        .read<SignInFormBloc>()
                        .state
                        .emailAddress
                        .value
                        .fold(
                          (f) => f.maybeMap(
                            auth: (authFailure) => authFailure.f.maybeMap(
                              invalidEmail: (_) => 'Invalid Email',
                              orElse: () => null,
                            ),
                            orElse: () => null,
                          ),
                          (r) => null,
                        ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(height: 10.r),
                SizedBox(
                  width: 400.r,
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: const Text('Password'),
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 24.r,
                      ),
                    ),
                    autocorrect: false,
                    obscureText: true,
                    onChanged: (value) => context
                        .read<SignInFormBloc>()
                        .add(SignInFormEvent.passwordChanged(value)),
                    validator: (_) => context
                        .read<SignInFormBloc>()
                        .state
                        .password
                        .value
                        .fold(
                          (f) => f.maybeMap(
                            auth: (authFailure) => authFailure.f.maybeMap(
                              shortPassword: (_) => 'Short Password',
                              orElse: () => null,
                            ),
                            orElse: () => null,
                          ),
                          (r) => null,
                        ),
                    textInputAction: TextInputAction.done,
                  ),
                ),
                SizedBox(height: 10.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40.r,
                      width: 120.r,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .signInWithEmailAndPasswordPressed(),
                              );
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                    SizedBox(width: 10.r),
                    SizedBox(
                      height: 40.r,
                      width: 120.r,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .registerWithEmailAndPasswordPressed(),
                              );
                        },
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.r),
                SizedBox(
                  height: 40.r,
                  width: 240.r,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<SignInFormBloc>().add(
                            const SignInFormEvent.signInWithGooglePressed(),
                          );
                    },
                    child: const Text('Sign In with Google'),
                  ),
                ),
                if (state.isSubmiting) ...[
                  SizedBox(height: 20.r),
                  SizedBox(
                    width: 200.r,
                    child: const LinearProgressIndicator(),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
