
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:admin_portel/Approvals/request.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomePage/home_page_container.dart';
import 'StudentRecords/student_records.dart';
import 'Tracking/tracking_routes_list.dart';
import 'add_station.dart';
import 'auth.dart';
import 'bus_list.dart';
import 'manage_routes.dart';
import 'map_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.auth}) : super(key: key);

  final Auth auth;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GoogleMapController? mapController;


  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title:const Text("Home Page"),
        centerTitle: true,

      ),

      drawer: Drawer(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: ListView(
            children:
            [
              ListTile(
                onTap: () => confirm(context),
                leading: const Text("LogOut"),
                trailing: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 70.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomePageContainer(image: "assets/bus.png", text: "Bus Records", onPress: manage_buses,),
                  HomePageContainer(image: "assets/tracker.png", text: "Track Bus", onPress: track_bus,),
                ],
              ),

              const SizedBox(
                height: 30.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomePageContainer(image: "assets/records.png", text: "Student records", onPress: student_records,),

                  HomePageContainer(image: "assets/approval.png", text: "Student requests", onPress: student_request,),

                  //HomePageContainer(image: "assets/approval.png", text: "Student complaints",),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomePageContainer(image: "assets/routes.png", text: "Manage Routes", onPress: manage_routes,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

   signOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut().catchError((e){
      print(e);
    });
    Navigator.of(context).pop();
  }

  void confirm(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            content:const Text("Are you sure?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:const Size(100, 50),
                      ),
                      onPressed: (){
                    Navigator.of(context).pop();
                  }, child:const Text("Cancel")),

                  const SizedBox(
                    width: 10.0,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize:const Size(100, 50),
                    ),
                      onPressed:() async => await signOut(context), child:const Text("Ok")),
                ],
              ),
            ],
          );
        });
  }

  manage_buses() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const BusList()));
  }

  track_bus() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrackRoutesList()));
  }


  manage_routes(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ManageRoutes()));
  }

  student_records(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const StudentRecords()));
  }

  student_request(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Approvals(auth: Auth(),)));

  }

}
