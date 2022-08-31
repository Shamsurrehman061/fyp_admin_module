import 'package:admin_portel/Approvals/view_student_details.dart';
import 'package:admin_portel/buttons.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../auth.dart';
import '../requested_routes.dart';

class Approvals extends StatefulWidget {
  const Approvals({Key? key, required this.auth}) : super(key: key);

  final Auth auth;
  @override
  _ApprovalsState createState() => _ApprovalsState();
}

class _ApprovalsState extends State<Approvals>{

  final db = FirebaseDatabase.instance.ref().child("User");
  final app = FirebaseDatabase.instance.ref().child("Approve User");
  bool approval = false;

  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        title:const Text("Approvals"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FirebaseAnimatedList(
          query: db,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){
            Map values = snapshot.value as Map;
            String name = values['Name'];
            String reg = values['Registeration No'];


             delete(){
               db.child(name).remove();
            }

             approve() {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestedRoutes(name: name,)));
            }

            return Card(
              child: Container(
                width: double.infinity,
                height: 180,
                decoration:const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Name : " + name, style:const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text("Roll No : " + reg, style:const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Buttons(width: 50.0, color: Colors.blue, height: 50.0, btnTxt: 'View Details', onPress: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewStudentDetails(name: name,)));
                            },),

                            const SizedBox(
                              width: 120.0,
                            ),
                            Buttons(onPress: approve, color: Colors.blue, btnTxt: "Accept", height: 50.0, width: 50.0),

                            const SizedBox(
                              width: 10.0,
                            ),

                            Buttons(onPress: delete, color: Colors.blue, btnTxt: "Delete", height: 50.0, width: 70.0)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
