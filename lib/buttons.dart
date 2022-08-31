import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key? key, required this.onPress, required this.color,required this.btnTxt, required this.height, required this.width}) : super(key: key);

  final String btnTxt;
  final VoidCallback? onPress;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        child: Text(btnTxt),
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: Size(width, height),
      ),
    );
  }
}
