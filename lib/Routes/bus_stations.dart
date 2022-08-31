import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../add_station.dart';

class BusStations extends StatefulWidget {
  const BusStations({Key? key, required this.path}) : super(key: key);

  final String path;
  @override
  _BusStationsState createState() => _BusStationsState();
}

class _BusStationsState extends State<BusStations> {

  final db = FirebaseDatabase.instance.ref().child("Bus Routes");
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text("Select Bus"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FirebaseAnimatedList(
          query: db.child(widget.path).child("Buses"),
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index)
          {

            final key = snapshot.key.toString();

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStation(path: widget.path, busNo: key,)));
                },
                child: Container(
                  height: 50.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(child: Text(key)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
