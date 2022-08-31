import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapData extends StatefulWidget {
  const MapData({Key? key, required this.busNo}) : super(key: key);
  final String busNo;

  @override
  State<MapData> createState() => _MapDataState();
}

class _MapDataState extends State<MapData> {

  GoogleMapController? mapController;
  List<Marker> listMarker = <Marker>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPoints();
  }

  _getPoints() async{
    final initialPoints =await FirebaseDatabase.instance.ref().child("Bus").child(widget.busNo)
        .child("Routes").child("Initial point").get();

    final terminationPoints =await FirebaseDatabase.instance.ref().child("Bus").child(widget.busNo)
        .child("Routes").child("Termination point").get();

    Map initialValue = initialPoints.value as Map;
    String fLatitude = initialValue['latitude'];
    String fLongitude = initialValue['longitude'];
    double fLati = double.parse(fLatitude);
    double fLong = double.parse(fLongitude);
    String fLocation = initialValue['location'];

    Map terminationValue = terminationPoints.value as Map;
    String sLatitude = terminationValue['latitude'];
    String sLongitude = terminationValue['longitude'];
    double sLati = double.parse(sLatitude);
    double sLong = double.parse(sLongitude);
    String location = terminationValue['location'];
    getMarker(fLati,fLong, fLocation);
    getMarker(sLati,sLong, location);

  }

  getMarker(double fLati, double fLong, String location) async{
    Marker initialPointMarker = Marker(
      markerId: MarkerId(location),
      position: LatLng(fLati, fLong),
      icon: BitmapDescriptor.defaultMarker,
    );
    setState((){
      listMarker.add(initialPointMarker);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              markers: listMarker.map((e) => e).toSet(),
              onMapCreated: (controller){
                mapController = controller;
              },
              initialCameraPosition:const CameraPosition(
                target: LatLng(34.16, 73.22),
                zoom: 10,
              ),
            ),
          )
    );
  }

}
