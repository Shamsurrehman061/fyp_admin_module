
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'bus_list.dart';
import 'buttons.dart';

class EditBus extends StatefulWidget {
  const EditBus({Key? key, required this.busNo}) : super(key: key);

  final String busNo;

  @override
  _EditBusState createState() => _EditBusState();
}

class _EditBusState extends State<EditBus> {

  final TextEditingController _controller = TextEditingController();
  String get updatedBus => _controller.text;
  final db = FirebaseDatabase.instance.ref().child("Bus");
  @override
  Widget build(BuildContext context) {

    _controller.text = widget.busNo;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Edit Bus"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              style:const TextStyle(fontSize: 18),
            ),

            const SizedBox(
              height: 20.0,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Buttons(onPress: update, color: Colors.indigo, btnTxt: "Update", height: 50.0, width: 80.0),
                const SizedBox(
                  width: 10.0,
                ),
                Buttons(onPress: delete, color: Colors.indigo, btnTxt: "Delete", height: 50.0, width: 80.0),
                const SizedBox(
                  width: 10.0,
                ),
                Buttons(onPress: cancel, color: Colors.indigo, btnTxt: "Cancel", height: 50.0, width: 80.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void cancel() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const BusList()));
  }

  void delete() async{
    await db.child(widget.busNo).child("Bus No").child("Routes").remove();
    await db.child(widget.busNo).remove();
    showDialog(context: context, builder: (context){
      return Dialog(
        child: SizedBox(
          height: 100,
          width: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:[
              const Text("Bus deleted", style: TextStyle(fontSize: 20),),
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
                  _controller.clear();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const BusList()));
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  void update() async{

    await db.child(widget.busNo).child("Bus No").child("Routes").remove();
    await db.child(widget.busNo).remove();
    db.child(updatedBus).set({
      'Bus No' : updatedBus,
    });

    showDialog(context: context, builder: (context){
      return Dialog(
        child: SizedBox(
          height: 100,
          width: 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Text("Bus updated", style: TextStyle(fontSize: 20),),

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
                  _controller.clear();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const BusList()));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}