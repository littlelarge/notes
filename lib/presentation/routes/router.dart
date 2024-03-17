import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/presentation/sign_in/sign_in_page.dart';
import 'package:notes/presentation/splash/splash_page.dart';

part 'router.g.dart';

final router = GoRouter(routes: $appRoutes);

@TypedGoRoute<SplashRoute>(
  path: '/',
)
class SplashRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

@TypedGoRoute<SignInRoute>(
  path: '/signIn',
)
class SignInRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SignInPage();
}
