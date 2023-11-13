import 'dart:convert';
import 'package:crypto/crypto.dart';


class Registry {
  
  String? uidDb;

  String? email;
  String? password;
  
  int? pkRol;
  String? name;
  String? apm;
  String? app;
  int? age;
  String? lada;   //cast to int
  int? telephone;
  int? pkLada;

  int? pkHouse;
  String? houseDescription;
  String? houseType;
  int? pkHouseType;
  String? housePassword;

  String? country;
  String? state;
  int? pkState;
  String? municipality;
  String? colony;
  String? street;
  String? extNum; //cast to int
  String? intNum; // cast to int 
  String? cp;     //cast to int

  Registry();

  @override
  String toString() {
    return 'UserInformation{'
      'UID: $uidDb, '
      'email: $email, '
      'password: $password, '
      'rol: $pkRol, '
      'name: $name, '
      'apm: $apm, '
      'app: $app, '
      'age: $age, '
      'lada: $lada, '
      'cve_lada: $pkLada, '
      'telephone: $telephone, '
      'cve_house: $pkHouse, '
      'houseDescription: $houseDescription, '
      'houseType: $houseType, '
      'cve_houseType: $pkHouseType, '
      'housePassword: $housePassword, '
      'country: $country, '
      'state: $state, '
      'cve_state: $pkState, '
      'municipality: $municipality, '
      'colony: $colony, '
      'street: $street, '
      'extNum: $extNum, '
      'intNum: $intNum, '
      'cp: $cp'
    '}';
  }

  Map<String,dynamic> allDatatoJson(){
    var passwordInBytes = utf8.encode(housePassword!);
    var password = sha256.convert(passwordInBytes);

    return {
      "crud": "INSERT",
      "data": {
        "Telefono":{
            "num_telefonico": telephone,
            "cve_lada": pkLada,
            "cve_persona": null,
        },
        "Persona": {
            "edad": age,
            "correo": email,
            "cve_nombre": null,
            "cve_tiporol": pkRol,
            "cve_casa": null,
            "uid_db": uidDb
        },        
        "Nombre": {
            "nombre": name,
            "apellido_paterno": app,
            "apellido_materno": apm,
        },
        "Casa": {
            "tamanio": null,
            "descripcion": houseDescription,
            "num_espacios": null,
            "contrasenia": password.toString(),
            "cve_direccion": null,
            "cve_tipopropiedad": pkHouseType,
            "cve_red": 1
        },
        "Direccion": {
            "Calle": street,
            "num_exterior": int.parse(extNum!),
            "num_interior": int.parse(intNum!),
            "cve_cp": null
        },
        "CP": {
            "descripcion": cp,
            "cve_colonia": null
        },
        "Colonia": {
            "descripcion": colony,
            "cve_municipio": null
        },
        "Municipio": {
            "descripcion": municipality,
            "cve_tipoestado": pkState
        },
      }
    };
  }

  Map<String,dynamic> userDatatoJson(){
    return {
      "crud": "INSERT",
      "data": {
        "Telefono":{
            "num_telefonico": telephone,
            "cve_lada": pkLada,
            "cve_persona": null,
        },
        "Persona": {
            "edad": age,
            "correo": email,
            "cve_nombre": null,
            "cve_tiporol": pkRol,
            "cve_casa": pkHouse,
            "uid_db": uidDb
        },
        "Nombre": {
            "nombre": name,
            "apellido_paterno": app,
            "apellido_materno": apm,
        },
      }
    };
  }
}

