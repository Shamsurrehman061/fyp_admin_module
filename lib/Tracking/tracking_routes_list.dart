import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../track_bus_list.dart';


class TrackRoutesList extends StatefulWidget {
  const TrackRoutesList({Key? key}) : super(key: key);

  @override
  _TrackRoutesListState createState() => _TrackRoutesListState();
}

class _TrackRoutesListState extends State<TrackRoutesList> {

  final db = FirebaseDatabase.instance.ref().child("Bus Routes");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Routes"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FirebaseAnimatedList(
          query: db,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index)
        {

          final data = snapshot.key.toString();

          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackBusList(route: data,)));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Ink(
                width: 200,
                height: 50,
                color: Colors.white,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                      ],
                    ),
                  ),
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
