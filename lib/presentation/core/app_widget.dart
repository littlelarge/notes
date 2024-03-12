import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/presentation/core/colours/colours.dart';
import 'package:notes/presentation/core/utils/sizes.dart';
import 'package:notes/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      child: const SignInPage(),
      builder: (context, child) => MaterialApp(
        title: 'Notes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colours.primary),
          useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          iconTheme: IconTheme.of(context).copyWith(size: 24.r),
          appBarTheme: AppBarTheme.of(context)
              .copyWith(toolbarHeight: Sizes.appBarHeight),
          textTheme: Theme.of(context).textTheme.copyWith(
                displayLarge: TextStyle(fontSize: 57.r),
                displayMedium: TextStyle(fontSize: 45.r),
                displaySmall: TextStyle(fontSize: 36.r),
                headlineLarge: TextStyle(fontSize: 32.r),
                headlineMedium: TextStyle(fontSize: 28.r),
                headlineSmall: TextStyle(fontSize: 24.r),
                titleLarge: TextStyle(fontSize: 22.r),
                titleMedium: TextStyle(fontSize: 16.r),
                titleSmall: TextStyle(fontSize: 14.r),
                labelLarge: TextStyle(fontSize: 14.r),
                labelMedium: TextStyle(fontSize: 12.r),
                labelSmall: TextStyle(fontSize: 11.r),
                bodyLarge: TextStyle(fontSize: 16.r),
                bodyMedium: TextStyle(fontSize: 14.r),
                bodySmall: TextStyle(fontSize: 12.r),
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: child,
      ),
    );
  }
}
