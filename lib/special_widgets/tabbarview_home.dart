import 'package:flutter/material.dart';
import 'package:proyectoiot/screens/home/garage.dart';

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
        Center(child: Text('Contenido de Tab 2')),
        Center(child: Text('Contenido de Tab 3')),
        Center(child: Text('Contenido de Tab 4')),
        Center(child: Text('Contenido de Tab 5')),
        Garage()
      ]
    );
  }
}