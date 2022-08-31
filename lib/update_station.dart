
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'add_station.dart';
import 'buttons.dart';

class EditStation extends StatefulWidget {
  const EditStation({Key? key, required this.location, required this.path, required this.point, required this.longitude, required this.latitude}) : super(key: key);

  final String location;
  final String path;
  final String point;
  final String latitude;
  final String longitude;

  @override
  _EditStationState createState() => _EditStationState();
}

class _EditStationState extends State<EditStation> {

  final db = FirebaseDatabase.instance.ref().child("Bus");

   final TextEditingController _locationController = TextEditingController();
   final TextEditingController _latitudeController = TextEditingController();
   final TextEditingController _longitudeController = TextEditingController();

  String get updatedLocation => _locationController.text;
  String get updatedLongitude => _longitudeController.text;
  String get updatedLatitue => _latitudeController.text;

  String departureHourInitialValue = "00";
  String departureSecondsInitialValue = "00";
  String arrivalHourInitialValue = "00";
  String arrivalSecondsInitialValue = "00";

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locationController.text = widget.location;
    _latitudeController.text = widget.latitude;
    _longitudeController.text = widget.longitude;
  }

  @override
  Widget build(BuildContext context) {



    void update(){
      final reference = db.child(widget.path).child("Routes").child(widget.point).set({
        'departure time' : departureHourInitialValue + " : " + departureSecondsInitialValue,
        'arrival time' : arrivalHourInitialValue + " : " + arrivalSecondsInitialValue,
        'location' : updatedLocation,
        'latitude' : updatedLatitue,
        'longitude' : updatedLongitude,
      });

      showDialog(context: context, builder: (builder){
        return Dialog(
          child: SizedBox(
            height: 100,
            width: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children:[
                const Text("Station updated", style: TextStyle(fontSize: 20),),

                const SizedBox(
                  height: 15.0,
                ),

                Buttons(
                  color: Colors.green,
                  btnTxt: "Ok",
                  width: 100.0,
                  height: 50.0,
                  onPress: (){
                    Navigator.of(context).pop();
                    _locationController.clear();
                   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStation(path: widget.path,)));
                  },
                ),
              ],
            ),
          ),
        );
      });
    }



    return Scaffold(
      appBar: AppBar(
        title:const Text("Edit Station"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius:const BorderRadius.all(Radius.circular(30.0),),
                  border: Border.all(color: Colors.black,),
                ),
                child: TextField(
                  decoration:const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style:const TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                  controller: _locationController,
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius:const BorderRadius.all(Radius.circular(30.0),),
                  border: Border.all(color: Colors.black,),
                ),
                child: TextFormField(
                  decoration:const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style:const TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                  controller: _latitudeController,
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius:const BorderRadius.all(Radius.circular(30.0),),
                  border: Border.all(color: Colors.black,),
                ),
                child: TextFormField(
                  decoration:const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style:const TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                  controller: _longitudeController,
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Select Arrival time"),

                  const SizedBox(
                    width: 20.0,
                  ),

                  DropdownButton(
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

                  const SizedBox(
                    width: 20.0,
                  ),

                  DropdownButton(
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
                ],
              ),

              const SizedBox(
                height: 20.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Select Departure time"),
                  const SizedBox(
                    width: 20.0,
                  ),
                  DropdownButton(
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

                  const SizedBox(
                    width: 20.0,
                  ),

                  DropdownButton(
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
                ],
              ),


              const SizedBox(
                height: 20.0,
              ),




              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Buttons(onPress: update, color: Colors.indigo, btnTxt: "Update", height: 50.0, width: 100.0),

                  const SizedBox(
                    width: 20.0,
                  ),

                  Buttons(onPress: delete, color: Colors.indigo, btnTxt: "Delete", height: 50.0, width: 100.0),

                  const SizedBox(
                    width: 20.0,
                  ),

                  Buttons(onPress: cancel, color: Colors.indigo, btnTxt: "Cancel", height: 50.0, width: 100.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void cancel(){
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStation(path: widget.path,)));
  }

   delete(){
    final reference = db.child(widget.path).child("Routes").child(widget.point).remove();
    Dialog(
      child: SizedBox(
        height: 100,
        width: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:[
            const Text("Station deleted", style: TextStyle(fontSize: 20),),

            const SizedBox(
              height: 15.0,
            ),
            Buttons(
              color: Colors.green,
              btnTxt: "Ok",
              width: 100.0,
              height: 50.0,
              onPress: (){
                Navigator.of(context).pop();
                _locationController.clear();
               // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStation(path: widget.path,)));
              },
            ),
          ],
        ),
      ),
    );
  }





  void changeState(String value) {
    setState(() {
      _locationController.text = value;
    });
  }
}