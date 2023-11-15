import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/shared/widget_functions.dart';
import '../models/house_info.dart';
import '../shared/constants.dart';

//----------------------------------------------------------------------
//Widget que muestra la barra deslizable entre los distintos espacios
//----------------------------------------------------------------------

class TabBarHome extends StatefulWidget {
  const TabBarHome({super.key});

  @override
  State<TabBarHome> createState() => _TabBarHomeState();
}

class _TabBarHomeState extends State<TabBarHome> {
  
  HouseInfo? houseInfo;

  IconData getIconForSpace(String spaceName) {
    // Ejemplo: puedes expandir esto para mapear diferentes nombres a diferentes íconos
    switch (spaceName) {
      case 'Cocina':
        return Icons.blender;
      case 'Dormitorio':
        return Icons.bed;
      case 'Jardin':
        return Icons.grass;
      case 'Garage':
        return Icons.time_to_leave;
      case 'Sala':
        return Icons.chair;
      case 'Comedor':
        return Icons.restaurant;
      case 'Baño':
        return Icons.wc;
      case 'Entrada':
        return Icons.meeting_room;
      case 'Estudio':
        return Icons.desk;
      case 'Atico':
        return Icons.roofing;       

      default:
        return Icons.home; // Un ícono predeterminado
    }
  }

  @override
  Widget build(BuildContext context) {

    houseInfo = Provider.of<HouseInfo>(context); // Obteniendo HouseInfo
    List<Tab> tabs;
    if(houseInfo!.espacios.isNotEmpty && houseInfo!=null){
      tabs = houseInfo!.espacios.entries.map((entry) {
        return Tab(text: replaceUnderscore(entry.key), icon: Icon(getIconForSpace(entry.value)));
      }).toList();
    } else{
      tabs = [const Tab(text: "General", icon: Icon(Icons.home))];
    }

    return TabBar(
      isScrollable: true,
      indicatorColor: color_11,
      labelColor: color_11,
      unselectedLabelColor: color_2,
      tabs: tabs
    );
  }
}