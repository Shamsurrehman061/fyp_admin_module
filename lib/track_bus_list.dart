import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'map_data.dart';


class TrackBusList extends StatefulWidget {
  const TrackBusList({Key? key, required this.route}) : super(key: key);

  final String route;


  @override
  _TrackBusListState createState() => _TrackBusListState();
}

class _TrackBusListState extends State<TrackBusList>{

  final db = FirebaseDatabase.instance.ref().child("Bus Routes");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Track bus"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0,),
        child: FirebaseAnimatedList(
          query: db.child(widget.route).child("Buses"),
          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation animation, int index){

            final data = snapshot.key.toString();


            // String? latitude = value['Latitude'];
            // String? longitude = value['Longitude'];

            gotoMap() => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MapData(busNo: data,)));

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: gotoMap,
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
                            "Bus No : " + data,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const IconButton(onPressed: null, icon:Icon(Icons.location_on_outlined)),
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
