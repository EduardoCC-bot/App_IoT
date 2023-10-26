import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/user_icon.dart';
import 'package:proyectoiot/shared/constants.dart';
import '../services/auth.dart';

//------------------------------
//Widget del Menú lateral/Drawer
//------------------------------


final AuthService _auth = AuthService();

final drawer = Drawer(
  backgroundColor: const Color(0xFF0f1b35),
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      userIcon,
      const Text("Usuario", style: drawerTextStyle),
      
      ListTile(
        tileColor: const Color(0xFFadd6f2),
        leading: Icon(Icons.priority_high, color: Colors.grey[100]),
        title: const Text('Notificaciones', style: TextStyle(color: Color(0xFFffffff)),),
        onTap: () => print('Home'),
      ),
      ListTile(
        tileColor: const Color(0xFFadd6f2),
        leading: Icon(Icons.settings, color: Colors.grey[100]),
        title: const Text('Configuración', style: TextStyle(color: Color(0xFFffffff)),),
        onTap: () => print('Configuración'), 
      ),
      ListTile(
        tileColor: const Color(0xFFadd6f2),
        leading: Icon(Icons.logout, color: Colors.grey[100]),
        title: const Text('Cerrar sesión', style: TextStyle(color: Color(0xFFffffff)),),
        onTap: () async {
          await _auth.signOut();
        },
      ),
      
      // .. Agregar más elementos de lista aquí
    
    
    ],
  ),
);