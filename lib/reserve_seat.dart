import 'package:admin_portel/seat_container.dart';
import 'package:admin_portel/seat_reserved_done.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class ReserveSeat extends StatefulWidget {
  const ReserveSeat({Key? key, required this.route, required this.busNo,  this.name}) : super(key: key);

  final String route;
  final String busNo;
  final String? name;

  @override
  _ReserveSeatState createState() => _ReserveSeatState();
}

class _ReserveSeatState extends State<ReserveSeat> {

  bool isSelected = false;
  bool seat1 = false;
  bool seat2 = false;
  bool seat3 = false;
  bool seat4 = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async{
    final data = await FirebaseDatabase.instance.ref().child("Bus Routes").child(widget.route).child("Buses").child(widget.busNo).get();
    Map val = data.value as Map;

    setState(() {
      seat1 = val['1'];
      seat2 = val['2'];
      seat3 = val['3'];
      seat4 = val['4'];
    });
  }

  @override
  Widget build(BuildContext context) {

    void reservedSeat(String seatNo)
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          SeatReservedDone(seatNo: seatNo, name: widget.name! ,busNo: widget.busNo, auth: Auth(),)));
    }

    return Scaffold(
      appBar: AppBar(
        title:const Text("Reserve Seat"),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SeatContainer(seatNo: seat1 ? "X" : "1", press: seat1 ? null : () => reservedSeat("1"), color: Colors.white,),
                  SeatContainer(seatNo: seat2 ? "X" : "2", press: seat2 ? null : () => reservedSeat("2"), color: Colors.white,),
                  SeatContainer(seatNo: seat3 ? "X" : "3", press: seat3 ? null : () => reservedSeat("3"), color: Colors.white,),
                  SeatContainer(seatNo: seat4 ? "X" : "4", press: seat4 ? null : () => reservedSeat("4"), color: Colors.white,),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children:const [
              //     SeatContainer(seatNo: '5',),
              //     SeatContainer(seatNo: '6',),
              //     SeatContainer(seatNo: '7',),
              //
              //   ],
              // ),
              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children:const [
              //     SeatContainer(seatNo: '9',),
              //     SeatContainer(seatNo: '10',),
              //     SeatContainer(seatNo: '11',),
              //     SeatContainer(seatNo: '12',),
              //   ],
              // ),
              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children:const [
              //     SeatContainer(seatNo: '13',),
              //     SeatContainer(seatNo: '14',),
              //     SeatContainer(seatNo: '15',),
              //     SeatContainer(seatNo: '16',),
              //   ],
              // ),
              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children:const [
              //     SeatContainer(seatNo: '17',),
              //     SeatContainer(seatNo: '18',),
              //     SeatContainer(seatNo: '19',),
              //     SeatContainer(seatNo: '20',),
              //   ],
              // ),
              //
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children:const [
              //     SeatContainer(seatNo: '21',),
              //     SeatContainer(seatNo: '22',),
              //     SeatContainer(seatNo: '23',),
              //     SeatContainer(seatNo: '24',),
              //   ],
              // ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children:const [
              //     SeatContainer(seatNo: '25',),
              //     SeatContainer(seatNo: '26',),
              //     SeatContainer(seatNo: '27',),
              //     SeatContainer(seatNo: '28',),
              //   ],
              // ),

              const SizedBox(
                height: 70.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
