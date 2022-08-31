import 'package:flutter/material.dart';

class SeatContainer extends StatelessWidget {
  const SeatContainer({Key? key, required this.seatNo, required this.press, required this.color}) : super(key: key);

  final String seatNo;
  final VoidCallback? press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black),
          borderRadius:const BorderRadius.all(Radius.circular(10.0))
        ),

        child: Center(child: Text(seatNo, style:const TextStyle(fontSize: 20.0),)),
      ),
    );
  }
}
