import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/user_icon.dart';
import 'package:proyectoiot/shared/constants.dart';
import '../services/auth.dart';

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
      //const Text("Perfil", style: drawerTextStyle),
      ListTile(
        tileColor: colorBlanco,
        leading: const Icon(Icons.notifications, color: color_11),
        title: const Text(
          'Notificaciones', 
          style: drawerTextStyle
        ),
        onTap: () => print('Notificaciones'),
      ),
      divider,
      ListTile(
        tileColor: colorBlanco,
        leading: const Icon(Icons.settings, color: color_11),
        title: const Text(
          'Configuraciones', 
          style: drawerTextStyle
        ),
        onTap: () => print('Configuración'), 
      ),
      divider,
      ListTile(
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