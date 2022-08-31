import 'package:admin_portel/reserve_bus.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


class RequestedRoutes extends StatefulWidget {
  const RequestedRoutes({Key? key, required this.name}) : super(key: key);

  final String name;
  @override
  _RequestedRoutesState createState() => _RequestedRoutesState();
}

class _RequestedRoutesState extends State<RequestedRoutes> {
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:const Text("Routes"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref().child("Bus Routes"),
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index)
          {
            final key = snapshot.key.toString();

            print(key);

            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReserveBus(route: key, name: widget.name,)));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                    [
                      Text(key),
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
