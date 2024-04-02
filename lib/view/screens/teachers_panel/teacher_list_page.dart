// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_cast
// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:attendance_mangement_system/view/resources/custom_widgets/text_styles.dart';

class TeacherListPage extends StatelessWidget {
  const TeacherListPage({
    super.key,
  });

  deleteData(teaEmail) async {
    QuerySnapshot snapshotTeacher =
        await FirebaseFirestore.instance.collection("Teacher List").get();

    for (var element in snapshotTeacher.docs) {
      if (element['email'] == teaEmail && element['role'] == "teacher") {
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection("Teacher List")
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTextStyles.primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Teacher List",
            style: CustomTextStyles.appBarText,
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("Teacher List").snapshots(),
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
                            trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context as BuildContext,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Do you want to remove this teacher?',
                                        style: TextStyle(
                                          fontSize: 21,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            deleteData(userMap["email"]);
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
                              icon: Icon(Icons.delete),
                            )),
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
