// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, unused_element, use_build_context_synchronously, must_be_immutable, avoid_web_libraries_in_flutter, unused_import, unused_local_variable
// ignore_for_file: prefer_const_constructors

import 'dart:html' as html;
import 'dart:js';

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
    super.key,
    required this.passDate,
  });

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
                          generateAndDownloadPDF();
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

  Future<void> generateAndDownloadPDF() async {
    // Create a new PDF document
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (context) {
          return TeachersPdf();
        },
      ),
    );

    // Save the PDF as bytes
    List<int> pdfBytes = await pdf.save();

    // Create a Blob object from the PDF bytes
    final blob = html.Blob([pdfBytes], 'application/pdf');

    // Create a temporary URL for the Blob object
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a link element
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', '($passDate)teacherAttendance.pdf')
      ..click();

    showDialog(
      context: context as BuildContext,
      builder: (context) => AlertDialog(
        title: Text('Students Attendance report Generated'),
        content:
            Text('The attendance report of teachers is saved at: downloads'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );

    // Revoke the temporary URL to free up memory
    html.Url.revokeObjectUrl(url);
  }
}
