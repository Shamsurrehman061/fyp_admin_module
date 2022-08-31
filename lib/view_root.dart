import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ViewRoot extends StatefulWidget {
  const ViewRoot({Key? key, required this.path, required this.busNo, required this.latLng}) : super(key: key);

  final String path;
  final String busNo;
  final List<LatLng> latLng;

  @override
  _ViewRootState createState() => _ViewRootState();
}

class _ViewRootState extends State<ViewRoot> {

  GoogleMapController? mapController;
  List<Marker> listMarker = <Marker>[];
  final Set<Polyline> polyLines = {};


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async{


    for(int i=0; i < widget.latLng.length; i++)
      {

        print(widget.latLng[i].latitude);
        double lati = widget.latLng[i].latitude;
        double long = widget.latLng[i].longitude;
        getMarker(lati, long, "peshawar");
      }

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

    polyLines.add(
      Polyline(
          polylineId: PolylineId("1"),
        points: widget.latLng,
        color: Colors.orange,
        width: 5,
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GoogleMap(
        markers: listMarker.map((e) => e).toSet(),
        onMapCreated: (controller){
          mapController = controller;
        },
        initialCameraPosition:const CameraPosition(
          target: LatLng(34.16, 73.22),
          zoom: 10,
        ),
        polylines: polyLines,
      ),
    );
  }
}
