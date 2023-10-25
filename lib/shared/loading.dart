import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[200],
      child: const Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0
          ) 
        ),
    );
  }
}