import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/models/house_info.dart';
import 'package:proyectoiot/shared/constants.dart';
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
  HouseInfo? houseInfo;
  
  @override
  Widget build(BuildContext context) {
    houseInfo = Provider.of<HouseInfo>(context); // Obteniendo HouseInfo

    if (houseInfo!.espacios.isEmpty) {
      // Si no hay espacios, muestra un mensaje en lugar de las vistas de pestañas
      return const TabBarView(
        children: [Center(child: Text("No hay nada que hacer por aquí", textAlign: TextAlign.center, style: TextStyle(color: color_0)))]
      );
    }

    List<Widget> tabViews = houseInfo!.espacios.keys.map((space) {
      return DevicesInASpace(space: space);
    }).toList();
    
    return TabBarView(children: tabViews);
  }
}