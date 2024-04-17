// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:attendance_mangement_system/model/list/teacher_list.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TeachersPdf extends pw.StatelessWidget {
  DateTime passDate = DateTime.now();
  @override
  pw.Widget build(pw.Context context) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            height: 40,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                "Date:",
              ),
              pw.SizedBox(
                width: 5,
              ),
              pw.Text(
                "${passDate.toLocal()}".split(' ')[0],
              ),
            ],
          ),
          pw.SizedBox(
            height: 25,
          ),
          pw.Container(
            height: 20,
            width: 200,
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(10),
              color: PdfColors.green,
            ),
            child: pw.Center(
              child: pw.Text(
                "Present Teachers: ",
                style: pw.TextStyle(fontSize: 18, color: PdfColors.white),
              ),
            ),
          ),
          pw.SizedBox(
            height: 10,
          ),
          pw.Expanded(
            child: pw.ListView.builder(
                itemCount: presentTeachers.length,
                itemBuilder: (context, index) => pw.Column(
                      children: [
                        pw.Row(
                          children: [
                            pw.Text(
                              (index + 1).toString() + ".",
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              presentTeachers[index],
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
          ),
          pw.SizedBox(
            height: 25,
          ),
          pw.Container(
            height: 20,
            width: 200,
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(10),
              color: PdfColors.red,
            ),
            child: pw.Center(
              child: pw.Text(
                "Absent Teachers: ",
                style: pw.TextStyle(fontSize: 18, color: PdfColors.white),
              ),
            ),
          ),
          pw.SizedBox(
            height: 10,
          ),
          pw.Expanded(
            child: pw.ListView.builder(
                itemCount: absentTeachers.length,
                itemBuilder: (context, index) => pw.Column(
                      children: [
                        pw.Row(
                          children: [
                            pw.Text(
                              (index + 1).toString() + ".",
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              absentTeachers[index],
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}
