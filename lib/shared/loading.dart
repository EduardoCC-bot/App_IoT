import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//------------------------------------------------
//Pantalla de carga
//------------------------------------------------

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  const Color(0xFFF6F6F6),
      child: const Center(
        child: SpinKitChasingDots(
          color:  Color(0xFF0f1b35),
          size: 50.0
          ) 
        ),
    );
  }
}