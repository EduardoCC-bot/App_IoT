import 'dart:js';
import 'package:flutter/material.dart';
import '../images_icons/user_icon.dart';
import '../services/auth.dart';
import '../shared/constants.dart';

final AuthService _auth = AuthService();


class AppDrawer extends StatelessWidget {
  final Function(int) onDrawerItemTapped;

  AppDrawer({required this.onDrawerItemTapped});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: colorBlanco,
        child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
        DrawerHeader(
        decoration: const BoxDecoration(
          color: color_1,
        ),
        child: userIcon,
        ),

        ListTile( //tile de notificaciones
        tileColor: colorBlanco,
        leading: const Icon(Icons.notifications, color: color_11),
        title: const Text(
          'Notificaciones', 
          style: drawerTextStyle
        ),
        onTap: (){              
              onDrawerItemTapped(0); // Indicar la selección de la opción 0
              Navigator.of(context).pop();
        },
        ),
        divider,
        ListTile( //tile de configuraciones
        tileColor: colorBlanco,
        leading: const Icon(Icons.settings, color: color_11),
        title: const Text(
          'Configuraciones', 
          style: drawerTextStyle
        ),
        onTap: (){
          onDrawerItemTapped(1); // Indicar la selección de la opción 1
          Navigator.of(context).pop();
        }, 
        ),
        divider,
        ListTile(      //tile de cerrar sesión
        tileColor: colorBlanco,
        leading: const Icon(Icons.logout, color: color_11),
        title: const Text(
          'Cerrar sesión', 
          style: drawerTextStyle
        ),
        onTap: () async {
          await _auth.signOut();
        },
        ),
        divider,
        // .. Agregar más elementos de lista aquí


        ],
        ),   );
  }
}
