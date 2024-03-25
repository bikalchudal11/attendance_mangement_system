// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:attendance_mangement_system/view/resources/routes/routes.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_report.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_report.dart';
import 'package:flutter/material.dart';

import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';

class FeaturesContainer extends StatelessWidget {
  FeaturesContainer({
    Key? key,
    required this.iconData,
    required this.name,
    required this.order,
  }) : super(key: key);
  String name;
  IconData iconData;
  int order;

  @override
  Widget build(BuildContext context) {
    DateTime passDate = DateTime.now();
    return InkWell(
      onTap: () {
        switch (order) {
          case 1:
            Navigator.pushNamed(context, Routes.addStudent);
            break;

          case 2:
            Navigator.pushNamed(context, Routes.addTeacher);
            break;
          case 3:
            Navigator.pushNamed(context, Routes.teacherAttendance);
            break;
          case 4:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => StudentReport(
                          passDate: passDate.toString(),
                        ))));
            break;
          case 5:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => TeacherReport(
                          passDate: passDate.toString(),
                        ))));
            break;
          case 6:
            Navigator.pushNamed(context, Routes.studentsList);
            break;
          case 7:
            Navigator.pushNamed(context, Routes.teacherList);
            break;
          case 8:
            Navigator.pushNamed(context, Routes.adminSettings);
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        height: 150,
        width: 170,
        decoration: BoxDecoration(
            border: Border.all(color: CustomTextStyles.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                size: 35,
              ),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
