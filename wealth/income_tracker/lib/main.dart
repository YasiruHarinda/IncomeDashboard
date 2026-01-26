import 'package:bloc/bloc.dart';
import 'package:income_tracker/app.dart';

import 'package:flutter/material.dart';
import 'simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

