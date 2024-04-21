import 'package:another_flushbar/flushbar_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/application/notes/note_form/note_form_bloc.dart';
import 'package:notes/domain/notes/note.dart';
import 'package:notes/injection.dart';
import 'package:notes/presentation/core/colours/colours.dart';
import 'package:notes/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:notes/presentation/notes/note_form/widgets/add_todo_tile_widget.dart';
import 'package:notes/presentation/notes/note_form/widgets/body_field_widget.dart';
import 'package:notes/presentation/notes/note_form/widgets/color_field_widget.dart';
import 'package:notes/presentation/notes/note_form/widgets/todo_list_widget.dart';
import 'package:provider/provider.dart';

class NoteFormPage extends StatelessWidget {
  const NoteFormPage({required this.editedNote, super.key});

  final Note? editedNote;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NoteFormBloc>()
        ..add(NoteFormEvent.initialized(optionOf(editedNote))),
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listenWhen: (previous, current) =>
            previous.saveFailureOrSuccessOption !=
            current.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(() {}, (either) {
            either.fold(
              (f) {
                FlushbarHelper.createError(
                  message: f.map(
                    insufficientPermission: (_) => 'Insufficient permissions ❌',
                    unableToUpdate: (_) => "Couldn't update the note. "
                        'Was it deleted from another device?',
                    unexpected: (_) =>
                        'Unexpected error occured, please contact support.',
                  ),
                ).show(context);
              },
              (_) => context.pop(),
            );
          });
        },
        buildWhen: (previous, current) => previous.isSaving != current.isSaving,
        builder: (BuildContext context, NoteFormState state) {
          return Stack(
            children: [
              const NoteFormPageScaffold(),
              SavingInProgressOverlay(
                isSaving: state.isSaving,
              ),
            ],
          );
        },
      ),
    );
  }
}

class SavingInProgressOverlay extends StatelessWidget {
  const SavingInProgressOverlay({
    required this.isSaving,
    super.key,
  });

  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colours.blackWithOpacity08 : Colours.transparent,
        width: 1.sw,
        child: Visibility(
          visible: isSaving,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(height: 16.r),
              Text(
                'Saving',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colours.primaryWhite,
                      fontSize: 32.r,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteFormPageScaffold extends StatelessWidget {
  const NoteFormPageScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NoteFormBloc, NoteFormState>(
          buildWhen: (previous, current) =>
              previous.isEditting != current.isEditting,
          builder: (context, state) =>
              Text(state.isEditting ? 'Edit a note' : 'Create a note'),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 14.r),
            onPressed: () {
              context.read<NoteFormBloc>().add(const NoteFormEvent.saved());
            },
            icon: const Icon(Icons.check_rounded),
          ),
        ],
      ),
      body: BlocBuilder<NoteFormBloc, NoteFormState>(
        buildWhen: (previous, current) =>
            previous.showErrorMessages != current.showErrorMessages,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => FormTodos(),
            child: Form(
              autovalidateMode: state.showErrorMessages,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    BodyField(),
                    ColorField(),
                    AddTodoTile(),
                    TodoList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
