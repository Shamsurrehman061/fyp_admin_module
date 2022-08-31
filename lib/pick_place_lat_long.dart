import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLatLng extends StatefulWidget {
  const PickLatLng({Key? key}) : super(key: key);

  @override
  _PickLatLngState createState() => _PickLatLngState();
}

const kGoogleApiKey = 'AIzaSyAuC3cYT6xtWuKfLD4M9d0w928C7Oq2UJ8';

class _PickLatLngState extends State<PickLatLng> {


  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startPosition =const LatLng(34.1688, 73.22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              zoomGesturesEnabled: true,
              onMapCreated: (controller){
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: startPosition,
                zoom: 10.0,
              ),
              onCameraMove: (CameraPosition cameraPosition){
                cameraPosition = cameraPosition;
              },
            ),
            Positioned(
              left: 330.0,
                right: 10.0,
                top: 20.0,
                child: Container(
                  color: Colors.white,
                  child: IconButton(
                      onPressed: (){},
                      icon:const Icon(Icons.search),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
