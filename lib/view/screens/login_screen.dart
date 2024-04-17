// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, override_on_non_overriding_member, annotate_overrides, use_build_context_synchronously

import 'package:attendance_mangement_system/view/resources/custom_widgets/custom_buttons.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/view/resources/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = false;

  Future logIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      // print("Please fill all the fields");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.yellow,
          content: Text(
            "Please fill all the fields!",
            style: TextStyle(color: Colors.black),
          )));
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // ignore: unnecessary_null_comparison
        if (userCredential != null) {
          setState(() {
            isLogin = true;
          });
          //for student
          QuerySnapshot snapshotStudent =
              await FirebaseFirestore.instance.collection("Student List").get();
          for (var element in snapshotStudent.docs) {
            if (element['email'] == email && element['role'] == "student") {
              Navigator.pushReplacementNamed(context, Routes.studentPanel);
              // print(element['email'] + " " + element['role']);
            }
          }

          //for teacher
          QuerySnapshot snapshotTeacher =
              await FirebaseFirestore.instance.collection("Teacher List").get();
          for (var element in snapshotTeacher.docs) {
            if (element['email'] == email && element['role'] == "teacher") {
              Navigator.pushReplacementNamed(context, Routes.teacherPanel);
            }
          }

          //for admin
          QuerySnapshot snapshotAdmin =
              await FirebaseFirestore.instance.collection("Admin").get();
          for (var element in snapshotAdmin.docs) {
            if (element['email'] == email && element['role'] == "admin") {
              Navigator.pushReplacementNamed(context, Routes.adminPanel);
            }
          }

          //for parents
          QuerySnapshot snapshotParent =
              await FirebaseFirestore.instance.collection("Parent List").get();
          for (var element in snapshotParent.docs) {
            if (element['email'] == email && element['role'] == "parent") {
              Navigator.pushReplacementNamed(context, Routes.parentPanel);
            }
          }
        }
      } on FirebaseAuthException catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.yellow,
            content: Text(
              ex.code.toString(),
              style: TextStyle(color: Colors.black),
            )));
        setState(() {
          isLogin = false;
        });
      }
    }
  }

  @override
  bool _obsecureText = true;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomTextStyles.primaryColor,
        body: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 400,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    child: Column(children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "email", prefixIcon: Icon(Icons.person)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: _obsecureText,
                        decoration: InputDecoration(
                            hintText: "password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obsecureText = !_obsecureText;
                                });
                              },
                              icon: Icon(
                                _obsecureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            )),
                      ),
                    ]),
                  ),
                  InkWell(
                    onTap: () {
                      logIn();
                    },
                    child: Column(
                      children: [
                        CustomButton(buttonName: "Log In"),
                        SizedBox(
                          height: 5,
                        ),
                        (isLogin)
                            ? CircularProgressIndicator(
                                color: Color.fromARGB(255, 247, 65, 9),
                              )
                            : SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
