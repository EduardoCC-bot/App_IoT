import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proyectoiot/shared/constants.dart';

//------------------------------------------------
//Pantalla de carga
//------------------------------------------------

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  colorBlanco,
      child: const Center(
        child: SpinKitChasingDots(
          color:  color_0,
          size: 50.0
          ) 
        ),
    );
  }
}