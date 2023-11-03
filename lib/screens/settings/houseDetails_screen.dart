import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';


//valores que obtendremos al hacer la conexion con la base de datos
String nombreCasa = '';
int numeroIntyegrantes = 0;

class houseDetails_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Casa'),
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
