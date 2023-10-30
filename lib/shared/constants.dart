import 'package:flutter/material.dart';

//----------------------------------------------------
//Formatos compartidos en distintos widgets y/o pantallas
//----------------------------------------------------

//formato para los campos de texto de login y register
const textInputDecoration =  InputDecoration(
    fillColor: colorBlanco,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: color_1, width: 1.0)
    ),
    focusedBorder: OutlineInputBorder(                        
      borderSide: BorderSide(color: color_11, width: 2.0)
    )
  );


//formato para el nombre de usuario en el Menú drawer
const drawerTextStyle = TextStyle(
  color: color_0,
  fontSize: 15,
);

//formato para las líneas divider
const divider = Divider(
      color: color_0,//especificar el color 
      height: 1.0, // Altura del Divider
      thickness: 0.5,
);

//paleta de colores
const color_0= Color(0xFF466A99);
final color_55= Colors.lightBlue[600];
const color_1= Color(0xFF75b1ff);
const color_2= Color(0xFFa1c4ff);
const color_3= Color(0xFFc5d8ff);
const color_4= Color(0xFFe5eeff);
const colorBlanco= Color(0xFFFFFFFF);
const colorSelect = Color(0xFF03A9F4);

const color_10= Color(0xFF652a00);
const color_11= Color(0xFFfdc165);
const color_12= Color(0xFFfed17e);
const color_13= Color(0xFFfff0af) ;
const color_14= Color(0xFFfee096);
const color_15= Color(0xFFffffc7);