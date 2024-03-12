import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/injection.dart';
import 'package:notes/presentation/core/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  configureInjection(Environment.prod);

  runApp(const AppWidget());
}
