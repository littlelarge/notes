// ignore_for_file: unused_result

import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes/domain/core/value_objects.dart';
import 'package:notes/domain/core/value_transformers.dart';
import 'package:notes/domain/core/value_validators.dart';

class NoteBody extends ValueObject<String> {
  factory NoteBody(String input) {
    return NoteBody._(
      validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }

  const NoteBody._(super.value);

  static const maxLength = 1000;
}

class TodoName extends ValueObject<String> {
  factory TodoName(String input) {
    return TodoName._(
      validateMaxStringLength(input, maxLength)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateSingleLine),
    );
  }

  const TodoName._(super.value);

  static const maxLength = 30;
}

class NoteColor extends ValueObject<Color> {
  factory NoteColor(Color input) {
    return NoteColor._(right(makeColorOpaque(input)));
  }

  const NoteColor._(super.value);

  static const List<Color> predefinedColors = [
    // #c7f8ff #c7ceff #eac7ff #ffc7ea #ffcec7 #fff8c7 #dcffc7 #c7ffdc
    Color(0xffc9f9ff), // 1
    Color(0xffc7ffdc), // 2
    Color(0xffdcffc7), // 3
    Color(0xfffff8c7), // 4
    Color(0xffffc7ea), // 6
    Color(0xffffcec7), // 5
    Color(0xffeac7ff), // 7
    Color(0xffc7ceff), // 8
  ];
}

class List3<T> extends ValueObject<KtList<T>> {
  factory List3(KtList<T> input) {
    return List3._(validateMaxListLength(input, maxLength));
  }

  const List3._(super.value);

  static const maxLength = 3;

  int get length {
    return value.getOrElse(emptyList).size;
  }

  bool get isFull {
    return length == maxLength;
  }
}
