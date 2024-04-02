// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_interpolation_to_compose_strings
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TeacherProfile extends StatelessWidget {
  String name, email, subject;
  TeacherProfile({
    super.key,
    required this.name,
    required this.email,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomTextStyles.primaryColor,
        title: Text(
          "Teacher Profile",
          style: CustomTextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
        child: Column(
          children: [
            // Container(
            //   width: 200,
            //   clipBehavior: Clip.antiAlias,
            //   decoration:
            //       BoxDecoration(borderRadius: BorderRadius.circular(15)),
            //   child: Image(
            //     image: AssetImage('assets/images/profile.jpg'),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name: ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email: ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "subject: ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  subject,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
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
