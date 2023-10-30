import 'package:flutter/material.dart';

//------------------------------------------------------------
//Imágenes. Esta en pruebas
//------------------------------------------------------------

final userIcon = Container (
  width: 160,
  height: 160,
  margin: const EdgeInsets.only(top: 20, bottom: 20),
  child : ClipRRect(
    child: Center(
      child: Image.network("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
    ),
  ),
);
