import 'package:flutter/material.dart';
import 'package:proyectoiot/screens/home/settings_screen.dart';
import '../../shared/constants.dart';
import '../../special_widgets/drawer_menu.dart';
import 'principal_screen.dart';
import 'notification_screen.dart';
//------------------------------------------------------------
//HOME. Pantalla a la que se accede una vez autentificado
//------------------------------------------------------------

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedDrawerItem = 0;
  String header='Inicio';

  void onDrawerItemTapped(int itemIndex) {
    String newHeader;
    switch(itemIndex) {
    case 0:
      newHeader = 'Inicio';
      break;
    case 1:
      newHeader = 'Notificaciones';
      break;
    case 2:
      newHeader = 'Configuraciones';
      break;
    default:
      newHeader = 'Opción no válida';
      break;
  }

  setState(() {
    selectedDrawerItem = itemIndex;
    header = newHeader;
  });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildScreen() {
    switch(selectedDrawerItem){
      case 0:
        return const PrincipalScreen();
      case 1:
        return const NotificationScreen();
      case 2:
        return const Settings();
      default:
        return const Center(child: Text('Opción no válida'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 6,
      child: Scaffold(
        backgroundColor: colorBlanco,
        drawer:  AppDrawer(onDrawerItemTapped: onDrawerItemTapped),
        appBar: AppBar(
          title: Text(header),
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
