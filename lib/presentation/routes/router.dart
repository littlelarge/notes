import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/domain/notes/note.dart';
import 'package:notes/presentation/notes/note_form/note_form_page.dart';
import 'package:notes/presentation/notes/notes_overview/notes_overview_page.dart';
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

@TypedGoRoute<NoteOverviewRoute>(
  path: '/noteOverview',
)
class NoteOverviewRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NoteOverviewPage();
}

@TypedGoRoute<NoteFormRoute>(
  path: '/noteForm',
)
class NoteFormRoute extends GoRouteData {
  NoteFormRoute(this.$extra);

  final Note? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => NoteFormPage(
        editedNote: $extra,
      );
}
