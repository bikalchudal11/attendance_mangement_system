// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:attendance_mangement_system/model/list/teacher_list.dart';
import 'package:attendance_mangement_system/view/resources/routes/routes.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_attendance_review.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_attendance_list_tile.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/custom_buttons.dart';
import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/model/list/student_list.dart';
import 'package:attendance_mangement_system/view/screens/student_panel/student_attendance_review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherAttendance extends StatefulWidget {
  const TeacherAttendance({super.key});

  @override
  State<TeacherAttendance> createState() => _TeacherAttendanceState();
}

class _TeacherAttendanceState extends State<TeacherAttendance> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    fetchTeachers();
    super.initState();
  }

  fetchTeachers() {
    return FirebaseFirestore.instance.collection("Teacher List").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomTextStyles.primaryColor,
        title: Text(
          "Teacher Attendance",
          style: CustomTextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                child: Text(
                  "Select Date",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
            ),
          ]),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: StreamBuilder<QuerySnapshot>(
                  stream: fetchTeachers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> userMap =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;

                              // print(studentName);
                              // print(absentStudent);
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (presentTeachers.contains(snapshot.data!
                                        .docChanges[index].doc['fullName'])) {
                                      presentTeachers.remove(snapshot.data!
                                          .docChanges[index].doc['fullName']);
                                    } else {
                                      presentTeachers.add(snapshot.data!
                                          .docChanges[index].doc['fullName']);
                                      print(presentTeachers);
                                    }
                                  });
                                },
                                child: Card(
                                  child: ListTile(
                                      title: Text(userMap["fullName"]),
                                      subtitle: Text(presentTeachers.contains(
                                              snapshot.data!.docChanges[index]
                                                  .doc['fullName'])
                                          ? "present"
                                          : "absent"),
                                      trailing: Container(
                                        margin: EdgeInsets.all(10),
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: presentTeachers.contains(
                                                    snapshot
                                                        .data!
                                                        .docChanges[index]
                                                        .doc['fullName'])
                                                ? Colors.green
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text(
                                          presentTeachers.contains(snapshot
                                                  .data!
                                                  .docChanges[index]
                                                  .doc['fullName'])
                                              ? "Present"
                                              : "Absent",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                      )
                                      // IconButton(
                                      //   onPressed: () {},
                                      //   icon: Icon(
                                      //     Icons.more_vert,
                                      //   ),
                                      // ),
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Text("No data!");
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
                // StudentAttendanceListTile()
                ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TeacherAttendanceReview(
                            presentTeacherData: presentTeachers,
                            absentTeacherData: absentTeachers,
                            passDate: "${selectedDate.toLocal()}"
                                .split(' ')[0]
                                .toString(),
                          )));
            },
            child: CustomButton(
              buttonName: "Save Attendance",
            ),
          )
        ],
      ),
    );
  }
}

// Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text("Roll No"),
//               Text("Name"),
//               Text("Present"),
//               Text("Absent"),
//             ],
//           ),
