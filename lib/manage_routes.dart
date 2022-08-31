import 'package:admin_portel/home_page.dart';
import 'package:admin_portel/view_route_details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'Routes/bus_stations.dart';
import 'add_bus_to_the_route.dart';
import 'add_route.dart';
import 'add_station.dart';
import 'auth.dart';
import 'edit_route_details.dart';
import 'homepage.dart';

class ManageRoutes extends StatefulWidget {
  const ManageRoutes({Key? key}) : super(key: key);

  @override
  _ManageRoutesState createState() => _ManageRoutesState();
}

class _ManageRoutesState extends State<ManageRoutes> {

  final db = FirebaseDatabase.instance.ref().child("Bus Routes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Routes"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) =>  HomePage(auth: Auth(),))
            );
          },
        ),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const AddRoute()));
          }, child:const Text("Add route"),
            style: ElevatedButton.styleFrom(elevation: 0.0),
          ),
        ],
      ),
      body: FirebaseAnimatedList(
        query: db,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index){
          // Map key = snapshot.key as Map;
          Map value = snapshot.value as Map;
          final initialPoint = value["Initial Point"];
          final destinationPoint = value['Destination Point'];
          final fullRoutes = snapshot.key.toString();

          addBus() {
            Navigator.of(context).push(MaterialPageRoute(
                builder:(context) => AddBusToTheRoute(
                      path: fullRoutes,
                    )));
          }

          addStation(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => BusStations(path: fullRoutes,)));
          }

          edit() {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditRouteDetails(
                  fullRoute: fullRoutes,
                      initialPoint: initialPoint,
                      destinationPoint: destinationPoint,
                    )));
          }

           viewDetails() {
            Navigator.of(context)
                .push(MaterialPageRoute(
                builder: (context) =>  RouteDetails(firstDestination: initialPoint,
                  secondDestination: destinationPoint,
                fullRoute: fullRoutes,)));
          }

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const SizedBox(
                    height: 10.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        initialPoint,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      const CircleAvatar(
                        child: Text("->"),
                      ),

                      Text(
                        destinationPoint,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: addBus,
                        child: const Text("Add bus"),
                      ),
                      ElevatedButton(
                        onPressed: addStation,
                        child: const Text("Add station"),
                      ),
                      ElevatedButton(
                        onPressed: viewDetails,
                        child: const Text("View details"),
                      ),
                      ElevatedButton(
                        onPressed: edit,
                        child: const Text("Edit"),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}
