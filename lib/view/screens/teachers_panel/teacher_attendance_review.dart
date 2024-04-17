// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:js';

import 'package:attendance_mangement_system/view/resources/custom_widgets/custom_buttons.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherAttendanceReview extends StatelessWidget {
  List<String> presentTeacherData;
  List<String> absentTeacherData;
  String passDate;
  TeacherAttendanceReview(
      {super.key,
      required this.passDate,
      required this.presentTeacherData,
      required this.absentTeacherData});

  storeDate(context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TeacherReport(
                  passDate: passDate,
                )));

    //for present teachers
    for (int i = 0; i < presentTeacherData.length; i++) {
      Map<String, dynamic> preStu = {"fullName": presentTeacherData[i]};
      FirebaseFirestore.instance
          .collection("Present Teacher List($passDate)")
          .doc(presentTeacherData[i])
          .set(preStu);
    }
    //for absent teachers
    for (int i = 0; i < absentTeacherData.length; i++) {
      Map<String, dynamic> absStu = {"fullName": absentTeacherData[i]};
      FirebaseFirestore.instance
          .collection("Absent Teacher List($passDate)")
          .doc(absentTeacherData[i])
          .set(absStu);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomTextStyles.primaryColor,
        title: Text(
          "Teacher Attendance Review",
          style: CustomTextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Date:",
                ),
                SizedBox(
                  width: 5,
                ),
                Text(passDate),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  "Present Teachers: ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: presentTeacherData.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    title: Text(
                      presentTeacherData[index],
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  "Absent Teachers: ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: absentTeacherData.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    title: Text(
                      absentTeacherData[index],
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Icon(
                      Icons.check_circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                //store the list of present and absent students
                storeDate(context);
              },
              child: CustomButton(
                buttonName: "Store Attendance",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
