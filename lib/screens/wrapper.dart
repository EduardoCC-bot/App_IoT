import 'package:flutter/material.dart';
import 'package:proyectoiot/models/user_model.dart';
import 'package:proyectoiot/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    //return Home o Authenticate
    if(user==null){
      return Authenticate();
    } else {
      return Home();
    }
    
  }
}