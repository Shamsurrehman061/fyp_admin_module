import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'bus_list.dart';

class AddBus extends StatefulWidget {
  const AddBus({Key? key,}) : super(key: key);

  @override
  _AddBusState createState() => _AddBusState();
}

class _AddBusState extends State<AddBus>{

  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _busNoController = TextEditingController();
  String get _busNo =>_busNoController.text;
  bool isLoading = false;

  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {

    Future<void> add()async{
      try{
        database.child("Bus").child(_busNo).set({
          'Bus No' : _busNo,
        });
      }
      catch(e)
      {
      }

      Future.delayed(const Duration(seconds: 5));
      showDialog(
          context: context,
          builder: (BuildContext context){
            return  AlertDialog(
              content:const Text("Bus added"),
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child:const Text("Ok")),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:const Icon(Icons.arrow_back), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) =>const BusList()));
        },),
        title:const Text("Add bus"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration:const InputDecoration(
                  hintText: "Bus No",
                  hintStyle: TextStyle(fontSize: 18),
                  contentPadding: EdgeInsets.only(left: 10.0),
                ),
                controller: _busNoController,
                textAlign: TextAlign.center,
                onChanged: change,
                validator: (value){
                  if(value!.isEmpty)
                    {
                      return "Vehicle No can't be empty";
                    }
                  else if(!RegExp(r'^[a-z A-Z 0-9]+$').hasMatch(value))
                    {
                      return "Vehicle No is wrong";
                    }
                  else
                    {
                      return null;
                    }
                },
              ),

              const SizedBox(
                height: 10.0,
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize:const Size(200, 50),
                ),
                onPressed: ()async{
                  if(_key.currentState!.validate())
                    {
                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                      setState(() {
                        isLoading = true;
                      });

                      await Future.delayed(const Duration(seconds: 5));

                      add();
                      setState((){
                        isLoading = false;
                      });

                      _busNoController.clear();
                    }
                },
                child: isLoading ? const SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  ) : const Text("Add")),

            ],
          ),
        ),
      ),
    );
  }


  void change(String value) {
    setState(() {
    });
  }


}
