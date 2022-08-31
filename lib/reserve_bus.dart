import 'package:admin_portel/reserve_seat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class ReserveBus extends StatefulWidget {
  const ReserveBus({Key? key, required this.route, required this.name}) : super(key: key);

  final String route;
  final String name;

  @override
  _ReserveBusState createState() => _ReserveBusState();
}

class _ReserveBusState extends State<ReserveBus>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:const Text("Select Bus"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref().child("Bus Routes").child(widget.route).child("Buses"),
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index)
        {
          Map val = snapshot.value as Map;
          final busNo = val['Bus No'];

          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ReserveSeat(route: widget.route,busNo: busNo, name: widget.name,)));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:
                  [
                    Text("Bus No : " + busNo),
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
