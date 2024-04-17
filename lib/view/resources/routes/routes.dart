import 'package:attendance_mangement_system/view/resources/custom_widgets/change_password_page.dart';
import 'package:attendance_mangement_system/view/screens/admin_panel/admin_setting.dart';
import 'package:attendance_mangement_system/view/screens/parent_panel/parent_home.dart';
import 'package:attendance_mangement_system/view/screens/parent_panel/parent_profile.dart';
import 'package:attendance_mangement_system/view/screens/splash_screen.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_setting.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/add_student_page.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/add_teacher_page.dart';
import 'package:attendance_mangement_system/view/screens/admin_panel/admin_home.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_attendance.dart';
import 'package:attendance_mangement_system/view/screens/login_screen.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_home.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_attendance.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_edit_page.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_list_page.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_home.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_list_page.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_setting.dart';
import 'package:flutter/material.dart';

class Routes {
  // splash
  static const String splash = '/';

  //login
  static const String loginScreen = '/loginScreen';

  //user type
  static const String studentPanel = '/studentPanel';
  static const String adminPanel = '/adminPanel';
  static const String teacherPanel = '/teacherPanel';
  static const String parentPanel = '/parentPanel';

  //student panel routes
  static const String studentsList = '/studentsList';
  static const String teachersList = '/teachersList';
  static const String studentSettings = '/studentSettings';
  static const String logOut = '/logOut';
  static const String changePassword = '/changePassword';

  //parent panel routes
  static const String parentProfile = '/parentProfile';

  //teacher panel routes
  static const String studentAttendance = '/studentAttendance';
  static const String teacherSetting = '/teacherSetting';
  static const String teacherList = '/teacherList';

  //admin panel routes
  static const String adminProfile = '/adminProfile';
  static const String addTeacher = '/addTeacher';
  static const String addStudent = '/addStudent';
  static const String teacherAttendance = '/teacherAttendance';
  static const String studentEdit = '/studentEdit';
  static const String teacherEdit = '/teacherEdit';
  static const String adminSettings = '/adminSettings';
}

class AppRouter {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/loginScreen':

        //user type
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/studentPanel':
        return MaterialPageRoute(builder: (_) => const StudentHome());
      case '/adminPanel':
        return MaterialPageRoute(builder: (_) => const AdminHome());
      case '/teacherPanel':
        return MaterialPageRoute(builder: (_) => const TeacherHome());
      case '/parentPanel':
        return MaterialPageRoute(builder: (_) => const ParentHome());

      //student
      case '/studentsList':
        return MaterialPageRoute(builder: (_) => const StudentListPage());
      case '/teacherList':
        return MaterialPageRoute(builder: (_) => const TeacherListPage());
      case '/studentSettings':
        return MaterialPageRoute(builder: (_) => const StudentSettings());
      case '/logOut':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/changePassword':
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());

      //parent
      case '/parentProfile':
        return MaterialPageRoute(builder: (_) => const ParentProfile());

      //teacher

      case '/studentAttendance':
        return MaterialPageRoute(builder: (_) => const StudentAttendance());

      case '/teacherSetting':
        return MaterialPageRoute(builder: (_) => const TeacherSetting());

      //admin
      case '/addTeacher':
        return MaterialPageRoute(builder: (_) => const AddTeacherPage());
      case '/addStudent':
        return MaterialPageRoute(builder: (_) => const AddStudentPage());
      case '/teacherAttendance':
        return MaterialPageRoute(builder: (_) => const TeacherAttendance());

      case '/studentEdit':
        return MaterialPageRoute(builder: (_) => const StudentEditPage());
      case '/adminSettings':
        return MaterialPageRoute(builder: (_) => const AdminSettings());

      default:
        return MaterialPageRoute(builder: (_) => const DefaultRoute());
    }
  }
}

class DefaultRoute extends StatelessWidget {
  const DefaultRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Invalid Route"),
      ),
    );
  }
}
