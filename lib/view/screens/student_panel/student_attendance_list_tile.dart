// // ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls

// import 'package:attendece_management_system/model/list/student_list.dart';
// import 'package:flutter/material.dart';

// class StudentAttendanceListTile extends StatefulWidget {
//   const StudentAttendanceListTile({super.key});

//   @override
//   State<StudentAttendanceListTile> createState() => _AttendanceListTileState();
// }

// class _AttendanceListTileState extends State<StudentAttendanceListTile> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: studentName.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(5),
//             child: InkWell(
//               onTap: () {
//                 setState(() {
//                   if (presentStudent.contains(studentName[index].toString())) {
//                     presentStudent.remove(studentName[index].toString());
//                     absentStudent.add(studentName[index].toString());
//                   } else {
//                     absentStudent.remove(studentName[index].toString());
//                     presentStudent.add(studentName[index].toString());
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
//                       studentName[index].toString(),
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     subtitle: Text(
//                         presentStudent.contains(studentName[index].toString())
//                             ? "present"
//                             : "absent"),
//                     trailing: Container(
//                       margin: EdgeInsets.all(10),
//                       height: 40,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           color: presentStudent
//                                   .contains(studentName[index].toString())
//                               ? Colors.green
//                               : Colors.red,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Center(
//                           child: Text(
//                         presentStudent.contains(studentName[index].toString())
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
