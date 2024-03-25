// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_cast, sort_child_properties_last, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unused_element, prefer_const_literals_to_create_immutables, avoid_web_libraries_in_flutter
// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({
    super.key,
  });

  deleteData(stuEmail, fatherName) async {
    QuerySnapshot snapshotStudent =
        await FirebaseFirestore.instance.collection("Student List").get();
    QuerySnapshot snapshotParent =
        await FirebaseFirestore.instance.collection("Parent List").get();

    for (var element in snapshotParent.docs) {
      if (element['fullName'] == fatherName && element['role'] == "parent") {
        DocumentReference documentReference2 = FirebaseFirestore.instance
            .collection("Parent List")
            .doc(element['fullName']);

        await documentReference2.delete();
      }
    }
    for (var element in snapshotStudent.docs) {
      if (element['email'] == stuEmail && element['role'] == "student") {
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection("Student List")
            .doc(element['fullName']);
        await documentReference.delete();
        try {
          User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await user.delete();
          }
        } catch (e) {
          print(e.toString());
        }
      }
    }
  }

  // showSnackbar(deleteStuName) {
  //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(
  //       SnackBar(content: Text("$deleteStuName is removed from the list")));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTextStyles.primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Student List",
            style: CustomTextStyles.appBarText,
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("Student List").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData && snapshot.data != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> userMap = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;
                      return Card(
                        child: ListTile(
                          title: Text(userMap["fullName"]),
                          subtitle: Text(userMap["email"]),
                          trailing: InkWell(
                            onTap: () {
                              showDialog(
                                context: context as BuildContext,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Do you want to remove this student?',
                                      style: TextStyle(
                                        fontSize: 21,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          deleteData(userMap["email"],
                                              userMap["fatherName"]);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    userMap["fullName"] +
                                                        " is removed from the list",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )));
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.delete,
                            ),
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
        ));
  }
}
