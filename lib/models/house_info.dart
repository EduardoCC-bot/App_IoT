import 'dart:core';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:proyectoiot/shared/widget_functions.dart';

class HouseInfo extends ChangeNotifier{
  
  int idCasa;
  String? nombreNoSQL;
  String? tipoCasa;
  int? idTipoCasa;
  String? direccion;
  Map<String, String> espacios = {};
  Map<String,List<dynamic>>? integrantesRol; //MAPA, CLAVE ES EL NOMBRE, VALOR ES UNA LISTA DEL ROL Y LA PK DEL ROL
  //EJEMPLO
  //["Eduardo Carreño Contreras" : [Propietario, 1], "Omar Díaz Buzo" : [Residente, 2]]



  HouseInfo({required this.idCasa});

   //Nombre NOSQL DE LA CASA
  Future<void> noSQLName(String casa) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("$casa/nombre"); // Asegúrate de especificar la ruta correcta
    DatabaseEvent event = await ref.once();
    if (event.snapshot.exists &&  event.snapshot.value != null) {
      nombreNoSQL = event.snapshot.value as String;
    }else{
      nombreNoSQL = replaceUnderscore(casa);
    }
    notifyListeners();
  }

  //INFORMACION DE LA CASA
  void updateFromApi(Map<String, dynamic> apiData) async {
    idTipoCasa = apiData['id_tipoCasa'];
    tipoCasa = apiData['tipo_casa'];
    direccion = apiData['direccion'];
    // Notificar a los oyentes que los datos han cambiado
    notifyListeners();
  }

  //INTEGRANTES DE LA CASA Y ROLES
  void updateHomeusers(Map<String, List<dynamic>> apiData){
    integrantesRol = apiData;
    notifyListeners();
  }

  Future<void> obtenerEspacios(String casa) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("$casa/Nombre_espacios"); // Asegúrate de especificar la ruta correcta
    DatabaseEvent event = await ref.once();

    if (event.snapshot.exists &&  event.snapshot.value != null) {
      Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
      espacios = data.map((key, value) => MapEntry(key.toString(), value.toString()));
    }else{
      espacios = {}; //no hay espacios
    }
    
    notifyListeners(); // Notifica a los oyentes sobre la actualización de los datos
  }

    @override
  String toString() {
  return 'HouseInfo: (idCasa: $idCasa, nombreNoSQL: $nombreNoSQL, tipoCasa: $tipoCasa, idTipoCasa: $idTipoCasa, direccion: $direccion, integrantesRol: $integrantesRol, espacios: $espacios)'; 
  }
}