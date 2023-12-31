import 'package:flutter/foundation.dart';

class UserInfo extends ChangeNotifier{
  
  String? uid;
  int? edad;
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? rol; //ROL
  String? casa;
  String? correo;
  int? pkCasa;
  int? cantEspacios;


  UserInfo();

  @override
  String toString() {
  return 'UserInfo(uid: $uid, edad: $edad, nombre: $nombre, apellidoPaterno: $apellidoPaterno, apellidoMaterno: $apellidoMaterno, rol: $rol, casa: $casa, pkCasa: $pkCasa, cantEspacios: $cantEspacios, correo: $correo)';
  }

  void updateFromApi(Map<String, dynamic> apiData) {
    edad = apiData['edad'];
    nombre = apiData['nombre'];
    apellidoPaterno = apiData['apellidoPaterno'];
    apellidoMaterno = apiData['apellidoMaterno'];
    rol = apiData['rol'];
    casa = apiData['casa'];
    correo = apiData['correo'];
    uid = apiData['uid'];
    pkCasa = apiData['pkCasa'];
    cantEspacios = apiData['cantEspacios'];

    // Notificar a los oyentes que los datos han cambiado
    notifyListeners();
  }
}