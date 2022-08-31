
import 'package:admin_portel/route.dart';
import 'package:admin_portel/view_root.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'manage_routes.dart';

class AddStation extends StatefulWidget {
  const AddStation({Key? key, required this.path, required this.busNo}) : super(key: key);

  final String path;
  final String busNo;
  @override
  _AddStationState createState() => _AddStationState();
}

class _AddStationState extends State<AddStation> {

  final db = FirebaseDatabase.instance.ref().child("Bus Routes");
  bool flag = false;
  List<LatLng> latLng = [];

  @override
  Widget build(BuildContext context) {
    final reference = db.child(widget.path).child("Buses").child(widget.busNo).child("Stations");

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: route, child:const Icon(Icons.location_on_outlined),),
      appBar: AppBar(
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) =>const ManageRoutes()));
        },),
        centerTitle: true,
        title:const Text("Stations"),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0
            ),
              onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (builder) => BusRoute(path: widget.path,busNo: widget.busNo,)
                ));
          },
              child:const Text("Add station", style: TextStyle(fontSize: 15.0),)),
        ],
      ),
      body: FirebaseAnimatedList(
        query: reference,
        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){



          Map val = snapshot.value as Map;
          final location = val['location'];
          String latitude = val['latitude'];
          String longitude = val['longitude'];
          final arrivalTime = val['arrival time'];
          final departureTime = val['departure time'];

          double sLati = double.parse(latitude);
          double sLong = double.parse(longitude);


          latLng.add(LatLng(sLati, sLong));

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2)
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("Location : " + location, textAlign: TextAlign.start ,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2,),),
                    Text("Latitude : " + latitude, textAlign: TextAlign.start ,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Text("Longitude : " + longitude, textAlign: TextAlign.start ,style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Text("Arrival Time : " + arrivalTime, textAlign: TextAlign.start ,style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Text("Departure Time : " + departureTime, textAlign: TextAlign.start ,style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

   route() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewRoot(path: widget.path, busNo: widget.busNo, latLng: latLng,)));
  }
}
