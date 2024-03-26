// ignore_for_file: prefer_const_constructors

import 'package:attendance_mangement_system/firebase_options.dart';
import 'package:attendance_mangement_system/view/resources/routes/routes.dart';
import 'package:attendance_mangement_system/view/screens/login_screen.dart';
import 'package:attendance_mangement_system/view/screens/splash_screen.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_report.dart';
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
      // after completion of the project
      onGenerateRoute: AppRouter.getRoute,
      initialRoute: Routes.teacherAttendance,
      // home: StudentReport(
      //   passDate: 'test',
      // ),
    );
  }
}
