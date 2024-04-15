// ignore_for_file: prefer_const_constructors

import 'package:attendance_mangement_system/firebase_options.dart';
import 'package:attendance_mangement_system/view/resources/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      // after completion of the project
      onGenerateRoute: AppRouter.getRoute,
      initialRoute: Routes.splash,
      // home: StudentReport(
      //   passDate: 'test',
      // ),
    );
  }
}
