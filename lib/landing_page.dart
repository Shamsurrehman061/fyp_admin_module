

import 'package:flutter/material.dart';

import 'auth.dart';
import 'home_page.dart';
import 'homepage.dart';
import 'my_Login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.auth}) : super(key: key);

  final Auth auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.auth.onAuthStateChange,
        builder: (BuildContext context,  snapshot){

        Users? user = snapshot.data as Users?;
        if(snapshot.connectionState == ConnectionState.active)
          {
            if(user == null)
              {
                return MyLogin(auth: Auth(),);
              }
            return HomePage(auth: Auth(),);
          }
        else
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
    });
  }
}
