import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/application/notes/note_watcher/note_watcher_bloc.dart';

class NotesOverviewBody extends StatelessWidget {
  const NotesOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteWatcherBloc, NoteWatcherState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadSuccess: (state) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final note = state.notes[index];

                if (note.failureOption.isSome()) {
                  return Container(
                    color: Colors.red,
                    width: 100.r,
                    height: 100.r,
                  );
                } else {
                  return Container(
                    color: Colors.green,
                    width: 100.r,
                    height: 100.r,
                  );
                }
              },
              itemCount: state.notes.size,
            );
          },
          loadFailure: (_) {
            return Container(color: Colors.yellow, width: 200.r, height: 200.r);
          },
        );
      },
    );
  }
}
