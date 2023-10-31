import 'package:flutter/material.dart';
import '../shared/constants.dart';

//------------------------------------------------------------
//Widget para desplegar el nombre de la casa
//------------------------------------------------------------

// ignore: must_be_immutable
class HouseName extends StatelessWidget {
  String name;
  HouseName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0), //ajustar el valor para el espaciado 
      child: Text(
        name, 
        style: const TextStyle(
          fontSize: 22,
          color: color_0,)
      ),
    );
  }
}