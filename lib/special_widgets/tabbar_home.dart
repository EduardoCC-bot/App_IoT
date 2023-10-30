import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      indicatorColor: color_11,
      labelColor: color_11,
      unselectedLabelColor: color_2,
      tabs: [
        Tab(text: "Todos", icon: Icon(Icons.home)),
        Tab(text: "Entrada", icon: Icon(Icons.meeting_room)),
        Tab(text: "Cocina", icon: Icon(Icons.blender)),
        Tab(text: "Habitación", icon: Icon(Icons.bed)),
        Tab(text: "Jardín", icon: Icon(Icons.grass)),
        Tab(text: "Garage", icon: Icon(Icons.time_to_leave)),
      ],
    );
  }
}
