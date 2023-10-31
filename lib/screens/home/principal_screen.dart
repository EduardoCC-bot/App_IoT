import 'package:flutter/material.dart';
import '../../special_widgets/sensors_display.dart';
import '../../special_widgets/tabbar_home.dart';
import '../../special_widgets/tabbarview_home.dart';

class PrincipalScreen extends StatelessWidget{
  const PrincipalScreen({super.key});
  @override
  Widget build(BuildContext context){
    return const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,  // Alinear widgets al inicio
        children: <Widget>[
          SizedBox(height: 80),
          SensorDisplay(),
          SizedBox(height: 20),
          TabBarHome(),
          Expanded(child: TabBarViewHome())
        ],
    );
  }
}