import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';


//valores que obtendremos al hacer la conexion con la base de datos
String nombreCasa = '';
int numeroIntyegrantes = 0;

class HouseDetailsScreen extends StatelessWidget {
  const HouseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casa'),
          centerTitle: true,
          backgroundColor: color_1,
          elevation: 5.0,

      ),
      body: const Center(
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
