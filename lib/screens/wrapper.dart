import 'package:flutter/material.dart';
import 'package:proyectoiot/models/user_model.dart';
import 'package:proyectoiot/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/screens/home/home.dart';
//import 'package:proyectoiot/screens/home/hometest.dart';

//----------------------------------------------------------------------------------
//Widget "Principal". Encargado de intercambiar entre Home y Authenticate
//----------------------------------------------------------------------------------

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    //return Home o Authenticate
    if(user==null){
      return const Authenticate();
    } else {
      // ignore: prefer_const_constructors
      return Home();
    }
    
  }
}