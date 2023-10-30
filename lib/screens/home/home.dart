import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/special_widgets/tabbar_home.dart';
import 'package:proyectoiot/special_widgets/tabbarview_home.dart';
import '../../special_widgets/drawer_menu.dart';
import '../../special_widgets/sensors_display.dart';

//------------------------------------------------------------
//HOME. Pantalla a la que se accede una vez autentificado
//------------------------------------------------------------

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: colorBlanco,
        drawer:  drawer,
        appBar: AppBar(
          title: const Text('Inicio'),
          centerTitle: true,
          //leading: const Icon(Icons.home),
          backgroundColor: color_1,
          elevation: 5.0,
        ),
        body: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,  // Alinear widgets al inicio
            children: <Widget>[
              SizedBox(height: 80),
              SensorDisplay(),
              SizedBox(height: 20),
              TabBarHome(),
              Expanded(child: TabBarViewHome())
            ],
          ),
      )
    );
  }
}