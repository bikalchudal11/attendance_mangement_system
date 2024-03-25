// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously

import 'package:attendance_mangement_system/view/resources/custom_widgets/custom_buttons.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_list_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({super.key});

  @override
  State<AddTeacherPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddTeacherPage> {
  TextEditingController tNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  void addTeacher() async {
    String tName = tNameController.text.trim();
    String dob = dobController.text.trim();
    String email = emailController.text.trim();
    String subject = subjectController.text.trim();

    if (tName != "" || dob != "" || email != "" || subject != "") {
      Map<String, dynamic> newTea = {
        "fullName": tName,
        "Date of birth": dob,
        "email": email,
        "subject": subject,
        "role": "teacher",
      };
      FirebaseFirestore.instance
          .collection("Teacher List")
          .doc(tName)
          .set(newTea);
      // print("user created");

      dobController.clear();
      emailController.clear();
      tNameController.clear();
      subjectController.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Teacher name $tName is added!"),
        backgroundColor: Colors.green,
      ));
      //also create their account for log in
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: "default");
        // print("user created");
      } on FirebaseException catch (ex) {
        // print(ex.code.toString());
      }
      //after adding student view the total student list
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TeacherListPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all the fields!"),
        backgroundColor: Colors.red,
      ));
      // print("user not created");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTextStyles.primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Add Teacher",
            style: CustomTextStyles.appBarText,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5),
              child: TextField(
                controller: tNameController,
                decoration: InputDecoration(labelText: "Teacher full name"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5),
              child: TextField(
                controller: dobController,
                decoration:
                    InputDecoration(labelText: "Date of birth (yy/mm/dd)"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5),
              child: TextField(
                controller: subjectController,
                decoration: InputDecoration(labelText: "Subject"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  addTeacher();

                  // }
                },
                child: CustomButton(
                  buttonName: "Add",
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
