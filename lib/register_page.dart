import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  final db = FirebaseDatabase.instance.ref().child("User");

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String get _name => _nameController.text;
  String get _reg => _regController.text;
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  String get _confirmPassword => _confirmPasswordController.text;


  @override
  Widget build(BuildContext context) {

    bool isTrue = _name.isEmpty || _reg.isEmpty || _email.isEmpty || _password.isEmpty || _confirmPassword.isEmpty;
    return Container (
       decoration: const BoxDecoration(
         image: DecorationImage(image: AssetImage('assets/register.png'),fit: BoxFit.fill)
    ),
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 40,top:40),
            child: const Text("Create \nAccount",
            style: TextStyle(
            color: Colors.white,
            fontSize: 33,
            fontStyle: FontStyle.italic,
            ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25,
            right: 35,
            left: 35,
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Name',
                    hintStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 25,
                ),
                TextField(
                  decoration: InputDecoration(
                     focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Registeration No',
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 25,
                ),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    decoration: InputDecoration(
                       focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                    validator: (value) => validate(value),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 25,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(                  
                     focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 25,
                ),
                 TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                   validator: (value) => validatePassword(value),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 30,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ignore: prefer_const_constructors
                    Text('Create',
                    style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.w700,
                    ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color(0xff4c505b),
                    child: IconButton(
                     color:Colors.white,
                     onPressed: !isTrue ? null : create,
                     icon: const Icon(Icons.arrow_forward),
                     ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
    );
  }

  validate(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  validatePassword(String? value) {
    if(_password != value)
      return "Password must be same";
    else
      return null;
  }

  create(){
    print("suck");
    db.child(_name).set({
      "Name": _name,
      "Email": _email,
      "password": _password,
      "Registeration No": _reg,
    });
  }
}