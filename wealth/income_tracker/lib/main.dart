
import 'package:flutter/material.dart';
import 'app.dart';
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}