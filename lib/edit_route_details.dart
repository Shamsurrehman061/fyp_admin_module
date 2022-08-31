import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'manage_routes.dart';

class EditRouteDetails extends StatefulWidget {
  const EditRouteDetails({Key? key, required this.destinationPoint, required this.initialPoint, required this.fullRoute}) : super(key: key);

  final String initialPoint;
  final String destinationPoint;
  final String fullRoute;
  @override
  _EditRouteDetailsState createState() => _EditRouteDetailsState();
}

class _EditRouteDetailsState extends State<EditRouteDetails> {

  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _initialPoint = TextEditingController();
  final TextEditingController _destinationPoint = TextEditingController();
  final db = FirebaseDatabase.instance.ref().child("Bus Routes");

  String get initialPoint => _initialPoint.text;
  String get destinationPoint => _destinationPoint.text;
  String get fullRoute => initialPoint + " -> To -> " + destinationPoint;
  bool isDelLoading = false;
  bool isUpdLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialPoint.text = widget.initialPoint;
    _destinationPoint.text = widget.destinationPoint;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:const Icon(Icons.arrow_back), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) =>const ManageRoutes()));
        },),
        title:const Text("Edit Route Details"),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: _key,
          child: Column(
            children: [

              TextFormField(
                decoration:const InputDecoration(
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


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const ManageRoutes()));
                  },child:const Text("Cancel"),),
                  ElevatedButton(onPressed:()async{
                    if(_key.currentState!.validate())
                    {
                      WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
                      setState(() {
                        isDelLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 5));

                      setState(() {
                        isDelLoading = false;
                      });

                      db.child(widget.fullRoute).remove();

                      showDialog(
                          context: context,
                          builder: (context)
                          {
                            return  AlertDialog(
                              content:const Text("Route Deleted Successfully"),
                              actions: [
                                ElevatedButton(onPressed: (){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const ManageRoutes()));
                                }, child:const Text("Ok")),
                              ],
                            );
                          }
                      );

                    }

                  }, child:isDelLoading ?const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    ),
                  ) :const Text("Delete route"),),
                  ElevatedButton(onPressed:()async{
                    if(_key.currentState!.validate())
                    {
                      WidgetsBinding.instance.focusManager.primaryFocus!.unfocus();
                      setState(() {
                        isUpdLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 5));

                      setState(() {
                        isUpdLoading = false;
                      });

                      db.child(widget.fullRoute).remove();
                      db.child(fullRoute).set({
                        "Initial Point" : initialPoint,
                        "Destination Point" : destinationPoint,
                      });


                      showDialog(
                          context: context,
                          builder: (context)
                          {
                            return  AlertDialog(
                              content:const Text("Route updated Successfully"),
                              actions: [
                                ElevatedButton(onPressed: (){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const ManageRoutes()));
                                }, child:const Text("Ok")),
                              ],
                            );
                          }
                      );
                    }

                  }, child:isUpdLoading ?const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    ),
                  ) :const Text("Update route"),),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }


}
