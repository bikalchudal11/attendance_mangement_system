// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unused_local_variable

import 'package:attendance_mangement_system/model/list/student_list.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/custom_buttons.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/view/resources/routes/routes.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_list_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  TextEditingController sNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController mNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void addStudent() async {
    String sName = sNameController.text.trim();
    String dob = dobController.text.trim();
    String fName = fNameController.text.trim();
    String mName = mNameController.text.trim();
    String email = emailController.text.trim();

    if (sName != "" || dob != "" || fName != "" || mName != "" || email != "") {
      Map<String, dynamic> newStu = {
        "fullName": sName,
        "Date of birth": dob,
        "fatherName": fName,
        "motherName": mName,
        "email": email,
        "role": "student"
      };
      Map<String, dynamic> newPra = {
        "fullName": fName,
        "spouseName": mName,
        "child": sName,
        "role": "parent",
        "email": fName.replaceAll(' ', '').toLowerCase() + "@gmail.com"
      };

      FirebaseFirestore.instance
          .collection("Student List")
          .doc(sName)
          .set(newStu);
      FirebaseFirestore.instance
          .collection("Parent List")
          .doc(fName)
          .set(newPra);

      //after adding student view the total student list
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StudentListPage()));

      // print("user created");
      sNameController.clear();
      dobController.clear();
      fNameController.clear();
      mNameController.clear();
      emailController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Student name $sName is added!"),
          backgroundColor: Colors.green,
        ),
      );

      //also create their account for log in
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: "default");

        UserCredential userCredential1 = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: fName.replaceAll(' ', '').toLowerCase() + "@gmail.com",
                password: "default");
        // print("user created");
      } on FirebaseException catch (ex) {
        print(ex.code.toString());
      }
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
            "Add Student",
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
                controller: sNameController,
                decoration: InputDecoration(labelText: "Student full name"),
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
                controller: fNameController,
                decoration: InputDecoration(labelText: "Father name"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5),
              child: TextField(
                controller: mNameController,
                decoration: InputDecoration(labelText: "Mother name"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  addStudent();
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
