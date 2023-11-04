import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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


typedef OnChangedCallback = void Function(String value);
TextFormField formBox (String hintText, String error, BuildContext context, OnChangedCallback onChangedCallback){
 return TextFormField(
      decoration: textInputDecoration.copyWith(hintText: hintText),
      validator: (val) => val!.isEmpty ? error : null,
      onChanged: onChangedCallback,
  );
}


Future<List<String>> getLada() async {
  var url = Uri.parse('http://189.131.88.67/api/v1/sql?db=SQL&crud=SELECT&dest=Lada');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((r) => r.toString()).toList();
    } else {
      // ignore: avoid_print
      print('Petición fallida: ${response.statusCode}.');
      return [];
    }
  } catch (e) {
    // ignore: avoid_print
    print(e.toString());
    return [];
  }
}