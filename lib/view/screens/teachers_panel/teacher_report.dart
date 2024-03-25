// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, unused_element, use_build_context_synchronously, must_be_immutable
// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teacher_attendance_data.dart';
import 'package:attendance_mangement_system/view/screens/teachers_panel/teachers_pdf.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class TeacherReport extends StatelessWidget {
  String passDate;
  TeacherReport({
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
            "Teachers Report",
            style: CustomTextStyles.appBarText,
          ),
          centerTitle: true,
        ),
        body: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TeacherAttendanceData(
                          passDate: passDate,
                        )));
          },
          child: Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: Text(
                  "1",
                  style: TextStyle(fontSize: 16),
                ),
                title: Text("Date: " + passDate),
                subtitle: Text("Click to view"),
                trailing: Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.edit)),
                      InkWell(
                        onTap: () {
                          _generateInvoice(context);
                        },
                        child: Icon(Icons.download),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _generateInvoice(BuildContext context) async {
    final pdf = pw.Document();

    // Create a PDF page
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: TeachersPdf(),
        );
      },
    ));

    // Get the directory for saving the PDF file
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/($passDate)TeachersAttendanceReport.pdf';
    final file = File(filePath);

    // Save the PDF file
    await file.writeAsBytes(await pdf.save());

    // Show a dialog to indicate the PDF is saved
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Teachers Attendance report Generated'),
        content:
            Text('The attendance report of teachers is saved at: $filePath'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
