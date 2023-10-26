import 'package:flutter/material.dart';

//----------------------------------------------------
//Formatos compartidos en distintos widgets y/o pantallas
//----------------------------------------------------

//formato para los campos de texto de login y register
const textInputDecoration =  InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)
    ),
    focusedBorder: OutlineInputBorder(                        
      borderSide: BorderSide(color: Colors.lightBlue, width: 2.0)
    )
  );


//formato para el nombre de usuario en el Menú drawer
const drawerTextStyle = TextStyle(
  color: Color(0xFFffffff),
  fontWeight: FontWeight.bold, 
  fontSize: 20,
);

