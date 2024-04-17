// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:attendance_mangement_system/model/list/student_list.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class StudentsPdf extends pw.StatelessWidget {
  DateTime passDate = DateTime.now();
  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
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
              "Present Students: ",
              style: pw.TextStyle(fontSize: 18, color: PdfColors.white),
            ),
          ),
        ),
        pw.SizedBox(
          height: 10,
        ),
        pw.ListView.builder(
            itemCount: presentStudent.length,
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
                          presentStudent[index],
                          style: pw.TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
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
              "Absent Students: ",
              style: pw.TextStyle(fontSize: 18, color: PdfColors.white),
            ),
          ),
        ),
        pw.SizedBox(
          height: 10,
        ),
        pw.ListView.builder(
            itemCount: presentStudent.length,
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
                          absentStudent[index],
                          style: pw.TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
      ],
    );
  }
}
