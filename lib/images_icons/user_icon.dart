import 'package:flutter/material.dart';

//------------------------------------------------------------
//Imágenes. Esta en pruebas
//------------------------------------------------------------

final userIcon = Container (
  width: 100,
  height: 100,
  margin: const EdgeInsets.only(top: 20, bottom: 20),
  child : ClipRRect(
    borderRadius  : BorderRadius.circular(20.0), // Ajusta el valor según el radio de curvatura que desees
    child: Container(
      color: const Color(0xFFffffff), // Color de fondo
      child: Center(
        child: Image.network("https://cdn-icons-png.flaticon.com/512/2910/2910721.png"),
      ),
    ),
  ),
);

