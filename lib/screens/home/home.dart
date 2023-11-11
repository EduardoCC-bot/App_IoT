import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/screens/home/settings_screen.dart';
import 'package:proyectoiot/shared/widget_functions.dart';
import '../../models/user_model.dart';
import '../../shared/constants.dart';
import '../../special_widgets/drawer_menu.dart';
import 'principal_screen.dart';
import 'notification_screen.dart';
//------------------------------------------------------------
//HOME. Pantalla contenedora a la que se accede una vez autentificado
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
  setState(() {
    selectedDrawerItem = itemIndex;
    header = getAppBarTitle(itemIndex);
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
    final user = Provider.of<UserModel?>(context);
    print(user);

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
