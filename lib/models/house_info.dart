import 'dart:core';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class HouseInfo extends ChangeNotifier{
  
  int idCasa;
  String? nombreNoSQL;
  String? tipoCasa;
  int? idTipoCasa;
  String? direccion;
  Map<String, String> espacios = {};
  List<String>? catrol;
  Map<String,List<dynamic>>? integrantesRol; //MAPA, CLAVE ES EL NOMBRE, VALOR ES UNA LISTA DEL ROL Y LA PK DEL ROL
  //EJEMPLO
  //["Eduardo Carreño Contreras" : [Propietario, 1], "Omar Díaz Buzo" : [Residente, 2]]



  HouseInfo({required this.idCasa});

  void updateFromApi(Map<String, dynamic> apiData) {
    nombreNoSQL = apiData['nombreNoSQL'];
    idTipoCasa = apiData['id_tipoCasa'];
    tipoCasa = apiData['tipo_casa'];
    direccion = apiData['direccion'];
    // Notificar a los oyentes que los datos han cambiado
    notifyListeners();
  }

  void updateHomeusers(Map<String, List<dynamic>> apiData, List<String> apicatrol){
    integrantesRol = apiData;
    catrol = apicatrol;
    catrol = catrol!.toSet().toList();
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