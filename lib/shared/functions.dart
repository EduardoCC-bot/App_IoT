import 'package:flutter/material.dart';

//funciones para obtener el icono correspondiente a cada sensor según su valor

IconData getIconForValor(String sensorName, num value) {
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
      return Icons.water_drop;
    }else{
      return Icons.format_color_reset;
    }
}

String getValueWithEscale(String sensorName, num value){
  switch (sensorName) {
    case 'temperatura':
      return "$value°C";
    case 'gas':
      return "$value ppm";
    case 'luz': 
      return "$value cd";
    case 'humedad':
      return "$value%";
    default:
      return "$value"; // ícono por defecto en caso de que no se reconozca el texto
  }
}