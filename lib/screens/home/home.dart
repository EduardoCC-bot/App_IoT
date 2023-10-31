import 'package:flutter/material.dart';
import 'package:proyectoiot/screens/home/settings.dart';
import '../../shared/constants.dart';
import '../../special_widgets/drawer_menu.dart';
import '../../special_widgets/sensors_display.dart';
import '../../special_widgets/tabbar_home.dart';
import '../../special_widgets/tabbarview_home.dart';
import '../../screens/home/principalScreen.dart';
//------------------------------------------------------------
//HOME. Pantalla a la que se accede una vez autentificado
//------------------------------------------------------------

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedDrawerItem = 0;

  void onDrawerItemTapped(int itemIndex){
    setState(() {
      selectedDrawerItem = itemIndex;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildScreen() {
    switch(selectedDrawerItem){
      case 0:
        return principalScreen();
      case 1:
        return settings();
      default:
        return Center(child: Text('Opción no válida'));
    }
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
        body: buildScreen(),
      ),      
    );
  }

}
