class Registry {
  
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
  String? housePassword;

  String? country;
  String? state;
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
      'housePassword: $housePassword, '
      'country: $country, '
      'state: $state, '
      'municipality: $municipality, '
      'colony: $colony, '
      'street: $street, '
      'extNum: $extNum, '
      'intNum: $intNum, '
      'cp: $cp'
    '}';
  }

  Map<String,dynamic> allDatatoJson(){
    return {
      "crud": "INSERT",
      "data": {
        "Persona": {
            "edad": age,
            "correo": email,
            "cve_nombre": null,
            "cve_rol": null,
            "cve_casa": null
        },
        "Telefono":{
            "num_telefonico": telephone,
            "cve_lada": null,
            "cve_persona": null,
        },
        "Lada": {
          "codigo": int.parse(lada!),
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
            "contrasenia": housePassword,
            "cve_direccion": null,
            "cve_tipopropiedad": null,
            "cve_red": null
        },
        "Direccion": {
            "Calle": street,
            "num_exterior": int.parse(extNum!),
            "num_interior": int.parse(intNum!),
            "cve_cp": null
        },
        "CP": {
            "descripcion": int.parse(cp!),
            "cve_colonia": null
        },
        "Colonia": {
            "descripcion": colony,
            "cve_municipio": null
        },
        "municipio": {
            "descripcion": municipality,
            "cve_estado": 10
        },
        "Red": {
            "ip": "200.10.0.10",
            "mascara": "255.255.255.0",
            "nombre_red": "HomeIoT",
            "contrasenia_red": "Home@IoT"
        }
      }
    };
  }

  Map<String,dynamic> userDatatoJson(){
    return {
      "crud": "INSERT",
      "data": {
        "Persona": {
            "edad": age,
            "correo": email,
            "cve_nombre": null,
            "cve_tiporol": pkRol,
            "cve_casa": pkHouse
        },
        "Telefono":{
            "num_telefonico": telephone,
            "cve_lada": pkLada,
            "cve_persona": null,
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

