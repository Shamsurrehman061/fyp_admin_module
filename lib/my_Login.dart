// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'auth.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key, required this.auth}) : super(key: key);

  final Auth auth;
  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  bool isLoading = false;
  bool passHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration:const InputDecoration(
                    hintText: 'Email',
                    border:OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )),
                controller: _emailController,
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "* Required";
                  }
                  else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value))
                  {
                    return "Enter correct email";
                  }
                  else
                  {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                obscureText: passHidden,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(passHidden ? Icons.visibility : Icons.visibility_off),
                    onPressed: togglePass,
                  ),
                  hintText: 'Password',
                  border:const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                controller: _passwordController,
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return "* Required";
                  }
                  else if(value.length < 6)
                  {
                    return "Password must be greater than 6 digits";
                  }
                  else
                  {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),

              ElevatedButton(
                onPressed: ()async{
                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                  if(_key.currentState!.validate())
                  {
                    setState(() {
                      isLoading = true;
                    });

                    await Future.delayed(const Duration(seconds: 5));
                    login();
                    setState((){
                      isLoading = false;
                    });
                  }
                },
                child: isLoading ?const SizedBox(
                  height: 16.0,
                  width: 16.0,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1.5,
                  ),
                ) : const Text("sign In"),
                style: ElevatedButton.styleFrom(
                  minimumSize:const Size(350, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
      widget.auth.signInWithEmailAddress(_email, _password).catchError((e){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return  AlertDialog(
                title:const Text("Sign In Failed"),
                content:const Text("Enter correct credentials"),
                actions: [
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child:const Text("Ok")),
                ],
              );
            });
      });
  }

  void togglePass() {
    setState(() {
      passHidden = !passHidden;
    });
  }
}
