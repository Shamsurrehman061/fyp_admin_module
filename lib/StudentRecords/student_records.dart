
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class StudentRecords extends StatefulWidget {
  const StudentRecords({Key? key}) : super(key: key);

  @override
  _StudentRecordsState createState() => _StudentRecordsState();
}

class _StudentRecordsState extends State<StudentRecords> {

  final db = FirebaseDatabase.instance.ref().child("Approve User");

  final dbb = FirebaseDatabase.instance.ref().child("Bus Routes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Records"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: FirebaseAnimatedList(
          query: db,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index){
            Map val = snapshot.value as Map;
            final name = val['Name'];
            final reg = val['Registeration No'];
            final busNo = val['Bus No'];
            final email = val['Email'];
            final route = val['route'];
            final seatNo = val['Seat No'];
            final uid = val['uid'];


            del(String uid, String seatNo, String busNo, String route)  {
              dbb.child(route).child("Buses").child(busNo).update({
                "$seatNo": false,
              });

              FirebaseDatabase.instance.ref().child("Approve User").child(uid).remove();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Name : " + name, style: const TextStyle(fontSize: 20.0),),
                      Text(
                        "Roll no : " + reg, style: const TextStyle(fontSize: 20.0),),
                      Text("Bus No" + busNo, style: const TextStyle(fontSize: 20.0),),
                      Text(
                        "Email : " + email, style:const TextStyle(fontSize: 20.0),),
                      Text(
                        "Route : " + route, style:const TextStyle(fontSize: 20.0),),
                      Text("Seat No : " + seatNo,
                        style: const TextStyle(fontSize: 20.0),),


                      Center(child: IconButton(onPressed:() => del(uid, seatNo, busNo, route), icon: Icon(Icons.delete),),),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }



}