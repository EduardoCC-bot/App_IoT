import 'package:proyectoiot/shared/constants.dart';
import 'package:flutter/material.dart';


//valores que obtendremos al hacer la conexion con la base de datos
String nombre = '';
String apellidoP = '';
String apellidoM = '';
int edad = 0;

class profile_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de perfil de usuario'),
          centerTitle: true,
          backgroundColor: color_1,
          elevation: 5.0,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Contenido de la pantalla de perfil de usuario
          ],
        ),
      ),
    );
  }
}
