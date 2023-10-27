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
  fontSize: 30,
);


const divider = Divider(
      color: Colors.grey, //especificar el color 
      height: 1.0, // Altura del Divider
);




IconData getIconoPorTexto(String sensorName, num value) {
    switch (sensorName) {
      case 'temperatura':
        return getIconoTemperatura(value);
      case 'gas':
        return getIconoGas(value);
      case 'luz': 
        return getIconoLuz(value);
      case 'humedad':
        return getIconoHumedad(value);
      default:
        return Icons.help; // ícono por defecto en caso de que no se reconozca el texto
    }
  }
  
IconData getIconoLuz(num value){
    if(value >= 80){
      return Icons.brightness_high;
    } else if(value >= 40){
      return Icons.brightness_medium;
    }else{
      return Icons.brightness_low;
    }
}

IconData getIconoTemperatura(num value){
    if(value >= 100){
      return Icons.local_fire_department;
    } else if(value >= 19){
      return Icons.thermostat;
    }else{
      return Icons.dew_point;
    }
}

IconData getIconoGas(num value){
    if(value >= 10){
      return Icons.gas_meter;
    }else{
      return Icons.propane_tank;
    }
}

IconData getIconoHumedad(num value){
    if(value >= 50){
      return Icons.water;
    } else if(value >= 20){
      return Icons.grass;
    }else{
      return Icons.shower;
    }
}