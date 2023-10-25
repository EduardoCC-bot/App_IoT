import 'package:flutter/material.dart';
import 'package:proyectoiot/screens/authenticate/register.dart';
import 'package:proyectoiot/screens/authenticate/login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  
  bool showLogIn = true;
  void toggleView(){
    setState(() => showLogIn = !showLogIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showLogIn == true){
      return LogIn(toggleView: toggleView);
    } else{
      return Register(toggleView: toggleView);
    }
  }
}