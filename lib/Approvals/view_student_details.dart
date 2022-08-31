import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class ViewStudentDetails extends StatefulWidget {
  const ViewStudentDetails({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<ViewStudentDetails> createState() => _ViewStudentDetailsState();
}

class _ViewStudentDetailsState extends State<ViewStudentDetails> {


  String name = "";
  String regNo = "";
  String password = "";
  String route = "";
  String email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  getData()async{
    final data = await FirebaseDatabase.instance.ref().child("User").child(widget.name).get();
    Map val = data.value as Map;

    setState(() {
      name = val["Name"];
      regNo = val["Registeration No"];
      password = val["password"];
      route = val["route"];
      email = val["Email"];
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            Text("Name" + name),
            Text("Roll No" + regNo),
            Text("Email" + email),
            Text("Routes" + route),
            Text("Password" + password),
          ],
        ),
      ),
    );
  }
}
