import 'package:flutter/material.dart';


class HomePageContainer extends StatelessWidget {
  const HomePageContainer({Key? key,  required this.image, required this.text, required this.onPress}) : super(key: key);

   final String image;
   final String text;
   final VoidCallback onPress;


  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        GestureDetector(
          onTap: onPress,
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.blueGrey)
            ),
            child: SizedBox(
              width: 95,
              height: 95,
                child: Image.asset(image, fit: BoxFit.cover,)),
          ),
        ),

       const SizedBox(
         height: 20.0,
       ),

        Text(text, style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ],
    );
  }
}
