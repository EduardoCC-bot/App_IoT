/*
Nombre de la casa NoSQL 
Tipo de propiedad SQL 
Direccion SQL
Integrantes con rol SQL List
pkCasa*/

import 'package:flutter/foundation.dart';

class HouseInfo extends ChangeNotifier{
  
  String idCasa;
  String? nombreNoSQL;
  String? tipoCasa;
  int? idTipoCasa;
  String? direccion;
  Map<String,List<dynamic>>? integrantesRol; //MAPA, CLAVE ES EL NOMBRE, VALOR ES UNA LISTA DEL ROL Y LA PK DEL ROL
  //EJEMPLO
  //["Eduardo Carreño Contreras" : [Propietario, 1], "Omar Díaz Buzo" : [Residente, 2]]


  HouseInfo({required this.idCasa});

  @override
  String toString() {
  return 'HouseInfo: (idCasa: $idCasa, nombreNoSQL: $nombreNoSQL, tipoCasa: $tipoCasa, idTipoCasa: $idTipoCasa, direccion: $direccion, integrantesRol: $integrantesRol)'; 
  }

  void updateFromApi(Map<String, dynamic> apiData) {
    // Notificar a los oyentes que los datos han cambiado
    notifyListeners();
  }
}