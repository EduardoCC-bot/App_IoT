// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'constants.dart';

//----------------------------------------------------------------------
//Archivo que contiene funciones utilizadas en distintas clases
//----------------------------------------------------------------------

//funciones para obtener el icono y escala correspondiente a cada sensor
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
    if(value >= 50){
      return Icons.local_fire_department;
    } else if(value >= 19){
      return Icons.thermostat;
    }else{
      return Icons.dew_point;
    }
}

IconData getIconoGas(num value){
    if(value >= 30){
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
      return "$value"; //  defecto en caso de que no se reconozca el texto
  }
}
//-----------------------------------------------------
//función para separar una cadena timestamp en fecha y hora
List<String> splitTimeStamp(String timestamp){
  List<String> timestampParts = timestamp.split('_');
  List<String> dateAndHour = [];
  String date = '${timestampParts[2]}/${timestampParts[1]}/${timestampParts[0]}';
  String hour = '${timestampParts[3]}:${timestampParts[4]}:${timestampParts[5]}';
  dateAndHour.add(date);
  dateAndHour.add(hour);
  return dateAndHour;
}

//función para obtener el título de la AppBar
String getAppBarTitle(int itemIndex){
  String newHeader;
  switch(itemIndex) {
    case 0:
      newHeader = 'Inicio';
      break;
    case 1:
      newHeader = 'Notificaciones';
      break;
    case 2:
      newHeader = 'Configuraciones';
      break;
    default:
      newHeader = 'Opción no válida';
      break;
  }
  return newHeader;
}

bool isNumeric(String? value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );
  return emailRegex.hasMatch(email);
}

typedef OnChangedCallback = void Function(String value);
TextFormField formBox (String hintText, String error, BuildContext context, OnChangedCallback onChangedCallback){
 return TextFormField(
      decoration: textInputDecoration.copyWith(hintText: hintText),
      validator: (val) => val!.isEmpty ? error : null,
      onChanged: onChangedCallback,
  );
}

String replaceSpaces(String text){
  String newText;
  newText = text.replaceAll(' ','_');
  return newText;
}

String replaceUnderscore(String text){
  String newText;
  newText = text.replaceAll('_',' ');
  return newText;
}