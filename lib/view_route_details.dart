import 'package:admin_portel/reserve_seat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'manage_routes.dart';

class RouteDetails extends StatefulWidget {
  const RouteDetails(
      {Key? key,
      required this.fullRoute,
      required this.firstDestination,
      required this.secondDestination})
      : super(key: key);

  final String fullRoute;
  final String firstDestination;
  final String secondDestination;

  @override
  _RouteDetailsState createState() => _RouteDetailsState();
}

class _RouteDetailsState extends State<RouteDetails> {
  String bus = "";
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) => const ManageRoutes()));
          },
        ),
        title: const Text("View Records"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Text("Route : ${widget.firstDestination}"),
                    Text("Initial Route : ${widget.firstDestination}", style:const TextStyle(fontWeight: FontWeight.bold),),
                    Text("Destination Route : ${widget.secondDestination}", style: const TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Buses", style: TextStyle(fontSize: 20),),
                    SizedBox(
                      height: 400.0,
                      width: 500.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: FirebaseAnimatedList(
                          query: FirebaseDatabase.instance.ref().child("Bus Routes").
                          child(widget.fullRoute).child('Buses'),
                          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){

                            Map values = snapshot.value as Map;
                            String? bus = values['Bus No'];

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Bus No : " + bus!),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReserveSeat(busNo: bus, route: widget.fullRoute,)));
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 30,
                                        color: Colors.grey,
                                          child:const Center(child: Text("View record"))),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}