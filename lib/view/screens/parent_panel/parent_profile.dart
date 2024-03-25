// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';
import 'package:flutter/material.dart';

class ParentProfile extends StatelessWidget {
  const ParentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: CustomTextStyles.primaryColor,
        title: Text(
          "Parent Profile",
          style: CustomTextStyles.appBarText,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Image(
                image: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text("Name: Bikal Chudal"),
            Text("Age: 16"),
            Text("Class: 10"),
            Text("Bio: I am very active person and i love playing basketball."),
            Text("Father Name: Jhonny Chudal"),
            Text("Mother Name: Kashi Maya Gurung Chudal"),
          ],
        ),
      ),
    );
  }
}
