
import 'package:admin_portel/homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'add_bus.dart';

import 'auth.dart';
import 'edit_bus.dart';
import 'home_page.dart';

class BusList extends StatefulWidget {
  const BusList({Key? key}) : super(key: key);

  @override
  _BusListState createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  final  _query = FirebaseDatabase.instance.ref().child("Bus");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (builder) =>  HomePage(auth: Auth(),)));
          },
        ),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const AddBus()));
          }, child:const Text("Add Bus"),
            style: ElevatedButton.styleFrom(elevation: 0.0),
          )
        ],
        title: const Text("Buses"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: FirebaseAnimatedList(
          defaultChild:const Center(child: CircularProgressIndicator(),),
          query: _query,
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){
            String busNo = snapshot.key.toString();
            print(busNo);
            return Padding(
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
                          "Bus No : " + busNo,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(onPressed: () {
                          print(busNo);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>EditBus(busNo: busNo,)));
                        }, icon: const Icon(Icons.edit)),
                      ],
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
