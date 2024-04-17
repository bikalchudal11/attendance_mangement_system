// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: prefer_const_constructors

import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/model/list/student_list.dart';
import 'package:flutter/material.dart';

class StudentAttendanceData extends StatelessWidget {
  String passDate;
  StudentAttendanceData({
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
                itemCount: presentStudent.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    title: Text(
                      presentStudent[index],
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
                itemCount: absentStudent.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    title: Text(
                      absentStudent[index],
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
          ],
        ),
      ),
    );
  }
}
