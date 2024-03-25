import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  const CriticalFailureDisplay({required this.noteFailure, super.key});

  final NoteFailure noteFailure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Center(
        heightFactor: 2.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/svg/error.svg',
              height: 150.r,
            ),
            SizedBox(height: 20.r),
            Text(
              noteFailure.maybeMap(
                insufficientPermission: (_) => 'Insufficient Permission',
                orElse: () => 'Unexpected error. Please contact support.',
              ),
              style: TextStyle(fontSize: 20.r),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
