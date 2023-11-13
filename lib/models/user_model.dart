class UserModel {
  
  String? uid;
  int? edad;
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? rol; //ROL
  String? casa;
  String? correo;


  UserModel();

  @override
  String toString() {
  return 'UserModel(uid: $uid, edad: $edad, nombre: $nombre, apellidoPaterno: $apellidoPaterno, apellidoMaterno: $apellidoMaterno, rol: $rol, casa: $casa, correo: $correo)';
  }
}

