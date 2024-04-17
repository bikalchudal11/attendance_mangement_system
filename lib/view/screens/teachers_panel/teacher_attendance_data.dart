// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: prefer_const_constructors

import 'package:attendance_mangement_system/model/list/teacher_list.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/custom_buttons.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_report.dart';
import 'package:flutter/material.dart';

class TeacherAttendanceData extends StatelessWidget {
  String passDate;
  TeacherAttendanceData({
    Key? key,
    required this.passDate,
  }) : super(key: key);

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
                itemCount: presentTeachers.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    title: Text(
                      presentTeachers[index],
                      // presentStudentData[index],
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
                itemCount: absentTeachers.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    title: Text(
                      absentTeachers[index],
                      // presentStudentData[index],
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
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeacherReport(
                              passDate: passDate,
                            )));
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
