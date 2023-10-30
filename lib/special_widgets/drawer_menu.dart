import 'package:flutter/material.dart';
import '../images_icons/user_icon.dart';
import '../services/auth.dart';
import '../shared/constants.dart';
import '../screens/home/principalScreen.dart';
import '../screens/home/settings.dart';

//------------------------------
//Widget del Menú lateral/Drawer
//------------------------------


final AuthService _auth = AuthService();

final drawer = Drawer(  
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
        onTap: () => print('Notificaciones'),
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
          print('Configuración');
          return ;
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
  ),
);


 getDrawerItemWidget(int pantalla){
    switch(pantalla){
      case 0:  return principalScreen();
      case 1: return settings();
      default: return null;
    }
  }