// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_init_to_null

import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/view/resources/routes/routes.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_profile.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  String name = "name";
  String email = "email";
  String dob = "dob";
  String fatherName = "fatherName";
  String motherName = "motherName";

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  _getUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      _fetchUserDetails(user);
    } catch (e) {
      print("Error changing password: $e");
    }
  }

  Future _fetchUserDetails(user) async {
    try {
      //For Student
      QuerySnapshot snapshotStudent =
          await FirebaseFirestore.instance.collection('Student List').get();
      for (var element in snapshotStudent.docs) {
        if (user.email == element['email']) {
          // print("success");
          setState(() {
            name = element['fullName'];
            email = element['email'];
            dob = element['Date of birth'];
            fatherName = element['fatherName'];
            motherName = element['motherName'];
          });
          // print(name);
        }
      }

      // print(user.email);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTextStyles.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Student Panel",
          style: CustomTextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        elevation: 0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: CustomTextStyles.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentProfile(
                            name: name,
                            email: email,
                            dob: dob,
                            fatherName: fatherName,
                            motherName: motherName)));
              },
            ),
            ListTile(
              leading: Icon(Icons.file_copy),
              title: Text("Report"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentReport(
                              passDate: "${selectedDate.toLocal()}"
                                  .split(' ')[0]
                                  .toString(),
                            )));
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text("Students List"),
              onTap: () {
                Navigator.pushNamed(context, Routes.studentsList);
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text("Teachers List"),
              onTap: () {
                Navigator.pushNamed(context, Routes.teacherList);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pushNamed(context, Routes.studentSettings);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.logOut);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_copy,
              size: 60,
            ),
            Text(
              "See Report",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: CustomTextStyles.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentReport(
                            passDate: "${selectedDate.toLocal()}"
                                .split(' ')[0]
                                .toString(),
                          ),
                        ));
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 45,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
