
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


import 'manage_routes.dart';

class AddRoute extends StatefulWidget {
  const AddRoute({Key? key}) : super(key: key);

  @override
  _AddRouteState createState() => _AddRouteState();
}

class _AddRouteState extends State<AddRoute> {

  
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _initialPoint = TextEditingController();
  final TextEditingController _destinationPoint = TextEditingController();
  final db = FirebaseDatabase.instance.ref().child("Bus Routes");

  String get initialPoint => _initialPoint.text;
  String get destinationPoint => _destinationPoint.text;
  String get fullRoute => initialPoint + " " + destinationPoint;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:const Icon(Icons.arrow_back), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const ManageRoutes()));
        },),
        title:const Text("Add Route"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: _key,
          child: Column(
            children: [

              TextFormField(
                decoration:const InputDecoration(
                  hintText: "Initial Point",
                  hintStyle: TextStyle(fontSize: 18),
                  contentPadding: EdgeInsets.only(left: 10.0),
                ),
                controller: _initialPoint,
                textAlign: TextAlign.center,
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "* Required";
                  }
                  else if(!RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value))
                  {
                    return "Initial Point is incorrect";
                  }
                  else
                  {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20.0,),
              TextFormField(
                decoration:const InputDecoration(
                  hintText: "Destination Point",
                  hintStyle: TextStyle(fontSize: 18),
                  contentPadding: EdgeInsets.only(left: 10.0),
                ),
                controller: _destinationPoint,
                textAlign: TextAlign.center,
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "* Required";
                  }
                  else if(!RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value))
                  {
                    return "Destination Point is incorrect";
                  }
                  else
                  {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(onPressed:()async{
                if(_key.currentState!.validate())
                  {
                    WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
                    setState(() {
                      isLoading = true;
                    });
                    addRoute();
                   await Future.delayed(const Duration(seconds: 5));
                    setState(() {
                      isLoading = false;
                    });

                    _initialPoint.clear();
                    _destinationPoint.clear();

                    showDialog(
                        context: context,
                        builder: (context)
                        {
                          return  AlertDialog(
                            content:const Text("Route added Successfully"),
                            actions: [
                              ElevatedButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, child:const Text("Ok")),
                            ],
                          );
                        }
                        );
                  }

              }, child:isLoading ? const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1.5,
                ),
              ) :const Text("Add Route"),)
            ],
          ),
        ),
      ),
    );
  }

  void addRoute() {
          db.child(fullRoute).set({
            "Initial Point" : initialPoint,
            "Destination Point" : destinationPoint,
          });
  }
}
