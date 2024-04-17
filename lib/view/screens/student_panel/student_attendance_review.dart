// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:attendance_mangement_system/model/list/report_list.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/custom_buttons.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentAttendanceReview extends StatelessWidget {
  List<String> presentStudentData;
  List<String> absentStudentData;
  String passDate;
  StudentAttendanceReview(
      {super.key,
      required this.passDate,
      required this.presentStudentData,
      required this.absentStudentData});

  storeDate(context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => StudentReport(
                  passDate: passDate,
                )));

    //for present students
    for (int i = 0; i < presentStudentData.length; i++) {
      Map<String, dynamic> preStu = {"fullName": presentStudentData[i]};
      FirebaseFirestore.instance
          .collection("Present Student List($passDate)")
          .doc(presentStudentData[i])
          .set(preStu);
    }
    //for absent students
    for (int i = 0; i < absentStudentData.length; i++) {
      Map<String, dynamic> absStu = {"fullName": absentStudentData[i]};
      FirebaseFirestore.instance
          .collection("Absent Student List($passDate)")
          .doc(absentStudentData[i])
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
          "Student Attendance Review",
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
                  "Present Students: ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: presentStudentData.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    title: Text(
                      presentStudentData[index],
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
                  "Absent Students: ",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: absentStudentData.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    title: Text(
                      absentStudentData[index],
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
                reportList.add(1);
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
