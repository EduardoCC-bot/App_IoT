import 'package:flutter/material.dart';
import '../screens/home/space_devices.dart';
//----------------------------------------------------------------------
//Contiene la pantalla correspondiente a cada espacio
//----------------------------------------------------------------------

class TabBarViewHome extends StatefulWidget {
  const TabBarViewHome({super.key});

  @override
  State<TabBarViewHome> createState() => _TabBarViewHomeState();
}

class _TabBarViewHomeState extends State<TabBarViewHome> {
  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: <Widget>[
        Center(child: Text('Contenido de Tab 1')),
        DevicesInASpace(space: "Entrada"),
        DevicesInASpace(space: "Cocina"),
        DevicesInASpace(space: "Habitacion"),
        DevicesInASpace(space: "Jardin"),
        DevicesInASpace(space: "Garage")
      ]
    );
  }
}

