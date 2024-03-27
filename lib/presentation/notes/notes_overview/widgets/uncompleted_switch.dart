import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/application/notes/note_watcher/note_watcher_bloc.dart';

class UncompletedSwitch extends HookWidget {
  const UncompletedSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final toggleSwitch = useState(false);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.r),
      child: InkWell(
        onTap: () {
          toggleSwitch.value = !toggleSwitch.value;

          context.read<NoteWatcherBloc>().add(
                toggleSwitch.value
                    ? const NoteWatcherEvent.watchUncompletedStarted()
                    : const NoteWatcherEvent.watchAllStarted(),
              );
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleSwitch.value
              ? const Icon(
                  Icons.check_box_outline_blank_rounded,
                  key: Key('check_box'),
                )
              : const Icon(
                  Icons.indeterminate_check_box_rounded,
                  key: Key('indeterminate'),
                ),
        ),
      ),
    );
  }
}
