import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes/application/notes/note_form/note_form_bloc.dart';
import 'package:notes/domain/notes/value_objects.dart';

class BodyField extends HookWidget {
  const BodyField({super.key});

  @override
  Widget build(BuildContext context) {
    final textEdittingController = useTextEditingController();

    return BlocListener<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.isEditting != current.isEditting,
      listener: (context, state) {
        textEdittingController.text = state.note.body.getOrCrash();
      },
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: TextFormField(
          controller: textEdittingController,
          decoration: const InputDecoration(
            label: Text('Note'),
            // to hide symbols count
            counterText: '',
          ),
          maxLength: NoteBody.maxLength,
          maxLines: null,
          minLines: 5,
          onChanged: (value) => context
              .read<NoteFormBloc>()
              .add(NoteFormEvent.bodyChanged(value)),
          validator: (_) => context
              .read<NoteFormBloc>()
              .state
              .note
              .body
              .value
              .fold(
                (f) => f.maybeMap(
                  notes: (notesFailure) => notesFailure.f.maybeMap(
                    empty: (f) => 'Cannot be empty',
                    exceedingLength: (f) => 'Exceeding length, max: ${f.max}',
                    orElse: () => null,
                  ),
                  orElse: () => null,
                ),
                (r) => null,
              ),
        ),
      ),
    );
  }
}
