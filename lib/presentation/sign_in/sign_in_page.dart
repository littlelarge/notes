import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:notes/injection.dart';
import 'package:notes/presentation/core/colours/colours.dart';
import 'package:notes/presentation/core/utils/sizes.dart';
import 'package:notes/presentation/sign_in/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colours.primaryWhite),
        ),
        centerTitle: true,
        backgroundColor: Colours.primary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        child: BlocProvider(
          create: (context) => getIt<SignInFormBloc>(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: Sizes.getScreenSizeWithoutAppBarHeight(value: .9),
              child: Column(
                children: [
                  SizedBox(height: .1.sh),
                  const SignInForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
