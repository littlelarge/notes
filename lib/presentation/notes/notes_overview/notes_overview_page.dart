import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/application/auth/auth_bloc.dart';
import 'package:notes/application/notes/note_actor/note_actor_bloc.dart';
import 'package:notes/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:notes/injection.dart';
import 'package:notes/presentation/core/colours/colours.dart';
import 'package:notes/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:notes/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:notes/presentation/routes/router.dart';

class NoteOverviewPage extends StatelessWidget {
  const NoteOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                unauthenticated: (_) => SignInRoute().go(context),
                orElse: () {},
              );
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                deleteFailure: (state) {
                  FlushbarHelper.createError(
                    duration: const Duration(seconds: 5),
                    message: state.noteFailure.map(
                      unexpected: (_) =>
                          'Unexpected error occured while deleting, '
                          'please contact support',
                      insufficientPermission: (_) => 'Insufficient permissions',
                      unableToUpdate: (_) => 'Impossible error',
                    ),
                  ).show(context);
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
              icon: const Icon(Icons.exit_to_app_rounded),
            ),
            actions: const [
              UncompletedSwitch(),
            ],
          ),
          body: const NotesOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              NoteFormRoute(null).push<NoteFormRoute>(context);
            },
            child: const Icon(Icons.add_rounded, color: Colours.primaryWhite),
          ),
        ),
      ),
    );
  }
}
