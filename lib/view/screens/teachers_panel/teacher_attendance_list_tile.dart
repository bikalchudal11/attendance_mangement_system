// // ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

// // ignore: unused_import
// import 'package:attendance_mangement_system/model/list/student_list.dart';
// import 'package:attendance_mangement_system/model/list/teacher_list.dart';
// import 'package:flutter/material.dart';

// class TeacherAttendanceListTile extends StatefulWidget {
//   const TeacherAttendanceListTile({super.key});

//   @override
//   State<TeacherAttendanceListTile> createState() => _AttendanceListTileState();
// }

// class _AttendanceListTileState extends State<TeacherAttendanceListTile> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: teachersName.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(5),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   if (presentTeachers
//                       .contains(teachersName[index].toString())) {
//                     presentTeachers.remove(teachersName[index].toString());
//                     absentTeachers.add(teachersName[index].toString());
//                   } else {
//                     absentTeachers.remove(teachersName[index].toString());
//                     presentTeachers.add(teachersName[index].toString());
//                   }
//                 });
//                 // studentName.forEach((element) {
//                 //   if (!presentStudent.contains(element)) {
//                 //     absentStudent.add(element);
//                 //   }
//                 // });
//               },
//               child: Card(
//                 child: ListTile(
//                     leading: Text(
//                       (index + 1).toString(),
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     title: Text(
//                       [index].toString(),
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     subtitle: Text(
//                         presentTeachers.contains(teachersName[index].toString())
//                             ? "present"
//                             : "absent"),
//                     trailing: Container(
//                       margin: EdgeInsets.all(10),
//                       height: 40,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           color: presentTeachers
//                                   .contains(teachersName[index].toString())
//                               ? Colors.green
//                               : Colors.red,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Center(
//                           child: Text(
//                         presentTeachers.contains(teachersName[index].toString())
//                             ? "Present"
//                             : "Absent",
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       )),
//                     )),
//               ),
//             ),
//           );
//         });
//   }
// }
