

import 'package:admin_portel/pick_place_lat_long.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_station.dart';
import 'buttons.dart';


class BusRoute extends StatefulWidget {
  const BusRoute({Key? key, required this.path, required this.busNo}) : super(key: key);

  final String path;
  final String busNo;

  @override
  State<BusRoute> createState() => _BusRouteState();
}

class _BusRouteState extends State<BusRoute> {

  final db = FirebaseDatabase.instance.ref().child("Bus Routes");

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  String get _location => _locationController.text;
  String get _latitude => _latitudeController.text;
  String get _longitude => _longitudeController.text;

  String longitude = "";

  // TimeOfDay _pickTimeArrival = const TimeOfDay(hour: 12, minute: 00);
  // TimeOfDay _pickTimeDeparture =const TimeOfDay(hour: 12, minute: 00);

  String? departureTime;
  String? arrivalTime;

  String arrivalValue = "Select arrival time";
  String departureValue = "Select departure time";

  bool arrFill = false;
  bool depFill = false;

  String? dropDownValue = "Initial point";

  String departureHourInitialValue = "00";
  String departureSecondsInitialValue = "00";
  String arrivalHourInitialValue = "00";
  String arrivalSecondsInitialValue = "00";

  @override
  Widget build(BuildContext context) {

    List items = ["Initial point", "Termination point"];

    List departureHourItem = ["00" ,"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
    List arrivalHourItem = ["00" ,"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
    List departureSecondItem = ["00" ,"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13",
      "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28",
      "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44",
      "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"];
    List arrivalSecondItem = ["00" ,"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13",
      "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28",
      "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44",
      "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"];


    setState(() {
      longitude = _location;
    });

    bool error =_location.isNotEmpty & _latitude.isNotEmpty & _longitude.isNotEmpty;

    void add()
    {
      try{
        db.child(widget.path).child("Buses").child(widget.busNo).child("Stations").child(_location).set({
          'location' : _location,
          'latitude' : _latitude,
          'longitude' : _longitude,
          'departure time' : departureHourInitialValue + " : " + departureSecondsInitialValue,
          'arrival time' : arrivalHourInitialValue + " : " + arrivalSecondsInitialValue,
        });
      }
      catch(e)
      {
        print(e);
      }

      showDialog(context: context, builder: (builder){
        return Dialog(
          child: Container(
            height: 150,
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Text("Route added", style: TextStyle(fontSize: 20),),
                const SizedBox(
                  height: 15.0,
                ),

                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green,
                  child: IconButton(icon: const Icon(Icons.done),onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStation(path: widget.path,busNo: widget.busNo,)));
                  },),
                ),
              ],
            ),
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title:const Text("Bus Routes"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            children: [

              const SizedBox(
                height: 20.0,
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius:const BorderRadius.all(Radius.circular(20.0)),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration:const InputDecoration(
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Enter location",
                    hintStyle: TextStyle(fontSize: 18, decoration: TextDecoration.none),
                  ),
                  autocorrect: false,
                  autofocus: false,
                  enableSuggestions: true,
                  style:const TextStyle( decoration: TextDecoration.none, fontSize: 22.0, fontWeight: FontWeight.w400),
                  controller: _locationController,
                  onChanged: _change,
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius:const BorderRadius.all(Radius.circular(20.0)),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Enter latitude of $longitude",
                    hintStyle:const TextStyle(fontSize: 18, decoration: TextDecoration.none),
                  ),
                  autocorrect: false,
                  autofocus: false,
                  enableSuggestions: true,
                  style:const TextStyle( decoration: TextDecoration.none, fontSize: 22.0, fontWeight: FontWeight.w400),
                  controller: _latitudeController,
                  onChanged: _change,
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius:const BorderRadius.all(Radius.circular(20.0)),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Enter longitude of $longitude",
                    hintStyle:const TextStyle(fontSize: 18, decoration: TextDecoration.none),
                  ),
                  autocorrect: false,
                  autofocus: false,
                  enableSuggestions: true,
                  style:const TextStyle( decoration: TextDecoration.none, fontSize: 22.0, fontWeight: FontWeight.w400),
                  controller: _longitudeController,
                  onChanged: _change,
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              const SizedBox(
                height: 20.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Select Arrival time",style: TextStyle(fontSize: 20),),

                  const SizedBox(
                    width: 20.0,
                  ),

                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.black, width: 2,),
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Center(
                      child: DropdownButton(
                        underline: Container(),
                        value: arrivalHourInitialValue,
                        items: arrivalHourItem.map((value){
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value));
                        }).toList(),
                        onChanged: (newValue){
                          setState(() {
                            arrivalHourInitialValue = newValue as String;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 20.0,
                  ),

                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.black, width: 2,),
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Center(
                      child: DropdownButton(
                        underline: Container(),
                        value: arrivalSecondsInitialValue,
                        items: arrivalSecondItem.map((value){
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value));
                        }).toList(),
                        onChanged: (newValue){
                          setState(() {
                            arrivalSecondsInitialValue = newValue as String;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Select Departure time", style: TextStyle(fontSize: 20),),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 80.0,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.black, width: 2,),
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Center(
                      child: DropdownButton(
                        underline: Container(),
                        value: departureHourInitialValue,
                        items: departureHourItem.map((value){
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value));
                        }).toList(),
                        onChanged: (newValue){
                          setState(() {
                            departureHourInitialValue = newValue as String;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 20.0,
                  ),

                  Container(
                    width: 80.0,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.black, width: 2,),
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: Center(
                      child: DropdownButton(
                        underline: Container(),
                        value: departureSecondsInitialValue,
                        items: departureSecondItem.map((value){
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value));
                        }).toList(),
                        onChanged: (newValue){
                          setState(() {
                            departureSecondsInitialValue = newValue as String;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),




              const SizedBox(
                height: 20.0,
              ),

              Buttons(
                color: Colors.indigo,
                  onPress: error ? add : null,
                  btnTxt: "Add",
                height: 50.0,
                width: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _change(String value) {
    setState(() {
    });
  }
}
