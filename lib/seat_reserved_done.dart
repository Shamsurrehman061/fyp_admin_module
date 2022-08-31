import 'package:admin_portel/homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'home_page.dart';

class SeatReservedDone extends StatefulWidget {
  const SeatReservedDone({Key? key,  required this.seatNo, required this.name, required this.busNo, required this.auth}) : super(key: key);

  final String seatNo;
  final String name;
  final String busNo;
  final Auth auth;

  @override
  _SeatReservedDoneState createState() => _SeatReservedDoneState();
}

class _SeatReservedDoneState extends State<SeatReservedDone> {

  bool isLoading = false;

  String name = "";
  String regNo= "";
  String route = "";
  String email = "";
  String password = "";
  String msg = "Your seat no has been reserved in bus no on root";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async{
    final data = await FirebaseDatabase.instance.ref().child("User").child(widget.name).get();

    Map val = data.value as Map;

    setState(() {
      name = val['Name'];
      regNo= val['Registeration No'];
      route = val['route'];
      email = val['Email'];
      password = val["password"];
    });
  }


  confirmSeat(String seatNo) async
  {
    final user = await widget.auth.createAccountWithEmailAddress(email, password);
    final uid = user?.uid;

    FirebaseDatabase.instance.ref().child("Bus Routes").child(route).child("Buses").child(widget.busNo).update(
        {
          "$seatNo" : true,
        }
    );

    setState(() {
      msg = "Your seat no ${widget.seatNo} has been reserved in bus no ${widget.busNo} on root $route";
    });


    FirebaseDatabase.instance.ref().child("Approve User").child(uid!).set({
      "Name" : name,
      "Registeration No" : regNo,
      "Email" : email,
      "password" : password,
      "Bus No" : widget.busNo,
      "Seat No" : widget.seatNo,
      "route" : route,
      "msg" : msg,
      "uid" : uid,
    });

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 5));


    setState((){
      isLoading = false;
    });


    final db =await FirebaseDatabase.instance.ref().child("User");
    db.child(widget.name).remove();
    Future.delayed(const Duration(seconds: 5));
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            content:const Text("Seat reserved"),
            actions: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(auth: Auth(),)));
              }, child:const Text("Ok")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title:const Text("Seat Reserved"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Center(
          child: Column(
            children: [
              Text("Name : " + name, style:const TextStyle(fontSize: 20),),
              Text("Registeration No : " + regNo, style:const TextStyle(fontSize: 20),),
              Text("Bus No : " + widget.busNo, style:const TextStyle(fontSize: 20),),
              Text("Seat No : " + widget.seatNo, style:const TextStyle(fontSize: 20),),
              Text("Route : " + route, style:const TextStyle(fontSize: 20),),

              const SizedBox(
                height: 20.0,
              ),

              ElevatedButton(onPressed:() => confirmSeat(widget.seatNo), child: isLoading ? const SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1,
                ),
              ) :  const Text("Confirm")),
            ],
          ),
        ),
      ),
    );
  }
}





