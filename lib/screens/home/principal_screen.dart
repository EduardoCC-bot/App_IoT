import 'package:flutter/material.dart';
import 'package:proyectoiot/special_widgets/house_name.dart';
import '../../special_widgets/sensors_display.dart';
import '../../special_widgets/tabbar_home.dart';
import '../../special_widgets/tabbarview_home.dart';

//------------------------------------------------------------
//Pantalla Inicio
//------------------------------------------------------------

class PrincipalScreen extends StatelessWidget{
  const PrincipalScreen({super.key});
  @override
  Widget build(BuildContext context){
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,  // Alinear widgets al inicio
        children: <Widget>[
          const SizedBox(height: 30),
          HouseName(name: "Casa inteligente"),
          const SensorDisplay(),
          const SizedBox(height: 20),
          const TabBarHome(),
          const Expanded(child: TabBarViewHome())
        ],
    );
  }
}