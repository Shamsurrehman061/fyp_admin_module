import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'manage_routes.dart';

class AddBusToTheRoute extends StatefulWidget {
  const AddBusToTheRoute({Key? key, required this.path}) : super(key: key);

  final String path;
  @override
  _AddBusToTheRouteState createState() => _AddBusToTheRouteState();
}

class _AddBusToTheRouteState extends State<AddBusToTheRoute>{

  final  _query = FirebaseDatabase.instance.ref().child("Bus");
  final database = FirebaseDatabase.instance.ref().child("Bus Routes");
  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) =>const ManageRoutes()));
          },
        ),
        title: const Text("Select Bus"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: FirebaseAnimatedList(
          defaultChild:const Center(child: CircularProgressIndicator(),),
          query: _query,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){

            String busNo = snapshot.key.toString();


            addBus() async{
              database.child(widget.path).child("Buses").child(busNo).set({
                'Bus No': busNo,
                '1' : false,
                '2' : false,
                '3' : false,
                '4' : false,
                '5' : false,
                '6' : false,
                '7' : false,
                '8' : false,
                '9' : false,
                '10' : false,
                '11' : false,
                '12' : false,
                '13' : false,
                '14' : false,
                '15' : false,
                '16' : false,
                '17' : false,
                '18' : false,
                '19' : false,
                '20' : false,
              });

              await Future.delayed(const Duration(seconds: 2));
            }


            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
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
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bus No : " + busNo,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),

                          IconButton(onPressed: addBus, icon:const Icon(Icons.add_rounded)),
                          //const Icon(Icons.add_rounded),
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
