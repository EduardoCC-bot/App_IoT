// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/registry.dart';

//listo
Future<Map<int, int>> getLada() async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20*%20FROM%20SOFIDBA_02.Lada");
  Map<int, int> ladaMap = {};
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var ladaPair in jsonResponse['OK']) {
          if (ladaPair is List && ladaPair.length >= 2) {
            int lada = ladaPair[0];
            int primaryKey = ladaPair[1];
            ladaMap[lada] = primaryKey;
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return ladaMap;
}

//listo
Future<List<String>> getCountryState(int lada) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20e.descripcion,e.id_tipoestado,%20p.descripcion%20FROM%20SOFIDBA_02.TipoEstado%20e,%20SOFIDBA_02.TipoPais%20p,%20SOFIDBA_02.Lada%20l%20WHERE%20l.codigo%20=%20$lada%20AND%20l.cve_tipoestado%20=%20e.id_tipoestado%20AND%20e.cve_tipopais%20=%20p.id_tipopais");
  List<String> countryState = [];

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      if (jsonResponse['OK'] != null) {
        for (var data in jsonResponse['OK']) {
          if (data is List && data.isNotEmpty) {
            // Añade cada elemento de la sublista a 'countryState'
            countryState.addAll(data.map((e) => e.toString()));
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return countryState;
}

//listo
Future<Map<String, int>> getHouseTypes() async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20*%20FROM%20SOFIDBA_02.Tipopropiedad");
  Map<String, int> houseTypes = {};
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var pair in jsonResponse['OK']) {
          if (pair is List && pair.length >= 2) {
            String typeName = pair[0]; // El nombre del tipo de casa es un String
            int typeId = pair[1]; // El ID asociado es un int
            houseTypes[typeName] = typeId; // Agrega el par al mapa
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return houseTypes;
}

//listo
Future<void> createHouse(Registry registry) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql");
  Map <String, dynamic> registryMap = registry.allDatatoJson();
  String body = jsonEncode(registryMap);
  print(body);
  try {
  final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
  
  if (response.statusCode == 200) {
    print(response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}


Future<int> isHouseNameUnique(String houseName) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT COUNT(*) FROM SOFIDBA_02.Casa casa WHERE casa.descripcion = '$houseName'");
  int flag = 0; // Variable para almacenar el número

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //decodifica la respuesta
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      //si el contenido de OK es diferente de nulo y es una lista
      if (jsonResponse['OK'] != null && jsonResponse['OK'] is List) {
        //obtengo la lista de OK
        List jsonResponseList = jsonResponse['OK'];
        //si la lista no está vacía y el primer elemento es otra lista
        if (jsonResponseList.isNotEmpty && jsonResponseList.first is List) {
          //obtengo la primera sublista
          List innerList = jsonResponseList.first;
          //si la sublista no está vacía y el primer elemento es entero, lo guardo
          if (innerList.isNotEmpty && innerList.first is int) {
            flag = innerList.first;
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  //regreso la flag
  print(flag);
  return flag;
}

//listo
Future<Map<String, dynamic>> getUserInfo(String uid) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT n.nombre, n.apellido_paterno, n.apellido_materno, p.edad, p.correo, r.descripcion, c.descripcion, p.uid_db, c.id_casa, (SELECT COUNT(*) FROM SOFIDBA_02.Espacio espacio WHERE Espacio.cve_casa = c.id_casa) FROM SOFIDBA_02.Nombre n, SOFIDBA_02.Persona p, SOFIDBA_02.TipoRol r, SOFIDBA_02.Casa c WHERE n.id_nombre = p.cve_nombre AND r.id_tiporol = p.cve_tiporol AND c.id_casa = p.cve_casa AND p.uid_db = '$uid'");
  Map<String, dynamic> userInfo = {};

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse['OK'] != null && jsonResponse['OK'].isNotEmpty) {
        var userArray = jsonResponse['OK'][0];
        if (userArray is List && userArray.length == 10) {
          // Llenar el mapa userInfo con los datos del usuario
          userInfo = {
            'nombre': userArray[0],
            'apellidoPaterno': userArray[1],
            'apellidoMaterno': userArray[2],
            'edad': userArray[3],
            'correo': userArray[4],
            'rol': userArray[5],
            'casa': userArray[6],
            'uid': userArray[7],
            'pkCasa': userArray[8],
            'cantEspacios': userArray[9]
          };
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }

  return userInfo;
}

//listo
Future<void> joinHouse(Registry registry) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql");
  Map <String, dynamic> registryMap = registry.userDatatoJson();
  String body = jsonEncode(registryMap);
  print(body);
  try {
  final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
  
  if (response.statusCode == 200) {
    print(response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

//listo
Future<int> verifyHouseCredentials(Registry registry) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20casa.id_casa%20FROM%20SOFIDBA_02.Casa casa%20WHERE%20casa.descripcion%20=%20%27${registry.houseDescription}%27%20AND%20casa.contrasenia%20=%20STANDARD_HASH(%27${registry.housePassword}%27,%20%27SHA256%27)");
  int flag = 0; // Variable para almacenar el número

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //decodifica la respuesta
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      //si el contenido de OK es diferente de nulo y es una lista
      if (jsonResponse['OK'] != null && jsonResponse['OK'] is List) {
        //obtengo la lista de OK
        List jsonResponseList = jsonResponse['OK'];
        //si la lista no está vacía y el primer elemento es otra lista
        if (jsonResponseList.isNotEmpty && jsonResponseList.first is List) {
          //obtengo la primera sublista
          List innerList = jsonResponseList.first;
          //si la sublista no está vacía y el primer elemento es entero, lo guardo
          if (innerList.isNotEmpty && innerList.first is int) {
            flag = innerList.first;
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  //regreso la flag
  return flag;
}

//listo
Future<Map<String, int>> getAreas(int pkCasa) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT e.descripcion, e.id_espacio FROM SOFIDBA_02.espacio e WHERE e.cve_casa = $pkCasa");
  Map<String, int> areas = {};
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var pair in jsonResponse['OK']) {
          if (pair is List && pair.length >= 2) {
            String typeName = pair[0]; // El nombre del espacio es un String
            int typeId = pair[1]; // El ID asociado es un int
            areas[typeName] = typeId; // Agrega el par al mapa
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return areas;
}

//listo
Future<Map<String, int>> getDevicesTypes() async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT t.descripcion, t.id_tipodispositivo FROM SOFIDBA_02.tipodispositivo t");
  Map<String, int> devicesTypes = {};
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var pair in jsonResponse['OK']) {
          if (pair is List && pair.length >= 2) {
            String typeName = pair[0]; // El nombre del espacio es un String
            int typeId = pair[1]; // El ID asociado es un int
            devicesTypes[typeName] = typeId; // Agrega el par al mapa
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return devicesTypes;
}

Future<Map<String, int>> getDevicesFromType(String type) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT t.descripcion, t.modelo, t.id_tipo$type FROM SOFIDBA_02.tipo$type t");
  Map<String, int> devicesFromTypes = {};
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var pair in jsonResponse['OK']) {
          if (pair is List && pair.length == 3) {
            String typeName = '${pair[0]} ${pair[1]}'; // Concatenando los dos primeros elementos
            int typeId = pair[2]; // El tercer elemento es un int
            devicesFromTypes[typeName] = typeId; // Agrega el par al mapa
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return devicesFromTypes;
}

Future<void> addDevice(String description, int cveSpace, int cveDevicefromtype, int cveDevicetype, String selectedDeviceType) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql");
  Map<String,dynamic> deviceJSON ={
    "crud": "INSERT",
    "data": {
      "Dispositivo":{
          "descripcion": description,
          "cve_espacio": cveSpace,
          "cve_tipo$selectedDeviceType": cveDevicefromtype,
          "cve_tipodispositivo": cveDevicetype
      }
    }
  };
  String body = jsonEncode(deviceJSON);
  print(body);
  try {
  final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
  
  if (response.statusCode == 200) {
    print(response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}

Future<int> verifyDevieUniqueName(String name, int pkSpace) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT COUNT(*) FROM SOFIDBA_02.dispositivo d WHERE d.descripcion = '$name' AND d.cve_espacio = $pkSpace");
  int flag = 0; // Variable para almacenar el número

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //decodifica la respuesta
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      //si el contenido de OK es diferente de nulo y es una lista
      if (jsonResponse['OK'] != null && jsonResponse['OK'] is List) {
        //obtengo la lista de OK
        List jsonResponseList = jsonResponse['OK'];
        //si la lista no está vacía y el primer elemento es otra lista
        if (jsonResponseList.isNotEmpty && jsonResponseList.first is List) {
          //obtengo la primera sublista
          List innerList = jsonResponseList.first;
          //si la sublista no está vacía y el primer elemento es entero, lo guardo
          if (innerList.isNotEmpty && innerList.first is int) {
            flag = innerList.first;
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  //regreso la flag
  return flag;
}

Future<int> verifyAreaUniqueName(String name, int pkHouse) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT COUNT(*) FROM SOFIDBA_02.Espacio e WHERE e.cve_casa = $pkHouse AND e.descripcion = '$name'");
  int flag = 0; // Variable para almacenar el número

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //decodifica la respuesta
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      //si el contenido de OK es diferente de nulo y es una lista
      if (jsonResponse['OK'] != null && jsonResponse['OK'] is List) {
        //obtengo la lista de OK
        List jsonResponseList = jsonResponse['OK'];
        //si la lista no está vacía y el primer elemento es otra lista
        if (jsonResponseList.isNotEmpty && jsonResponseList.first is List) {
          //obtengo la primera sublista
          List innerList = jsonResponseList.first;
          //si la sublista no está vacía y el primer elemento es entero, lo guardo
          if (innerList.isNotEmpty && innerList.first is int) {
            flag = innerList.first;
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  //regreso la flag
  return flag;
}

Future<Map<String, int>> getAreasTypes() async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT * FROM SOFIDBA_02.tipoespacio");
  Map<String, int> areaTypes = {};
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(utf8.decode(response.bodyBytes));      
      if (jsonResponse['OK'] != null) {
        for (var pair in jsonResponse['OK']) {
          if (pair is List && pair.length == 2) {
            String typeName = pair[0]; // Concatenando los dos primeros elementos
            int typeId = pair[1]; // El tercer elemento es un int
            areaTypes[typeName] = typeId; // Agrega el par al mapa
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return areaTypes;
}


Future<void> addArea(String description, int cveCasa, int cveTipoEspacio) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql");
  Map<String,dynamic> deviceJSON ={
    "crud": "INSERT",
    "data": {
      "Espacio":{
          "descripcion": description,
          "num_dispositivos": 0,
          "cve_tipoespacio": cveTipoEspacio,
          "cve_casa": cveCasa
      }
    }
  };
  String body = jsonEncode(deviceJSON);
  print(body);
  try {
  final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);
  
  if (response.statusCode == 200) {
    print(response);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}


//listo
Future<Map<String, dynamic>> getHouseInfo(int idCasa) async {
var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT * FROM SOFIDBA_02.V_HOUSEDETALIS where ID_casa = $idCasa");
  Map<String, dynamic> homeusersInfo = {};

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null && jsonResponse['OK'].isNotEmpty) {
        var homeArray = jsonResponse['OK'][0];
        if (homeArray is List && homeArray.length == 12) {
          // Llenar el mapa userInfo con los datos del usuario
          homeusersInfo = {
            'nombreNoSQL': homeArray[1],
            'id_tipoCasa': homeArray[2],
            'tipo_casa': homeArray[3],
            'direccion': homeArray[4] + ' ' + homeArray[5].toString() + ' ' + homeArray[6].toString() + ' ' + homeArray[7].toString() + ' ' + homeArray[8] + ' ' + homeArray[9] + ' ' + homeArray[10] + ' ' + homeArray[11],
          };
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  return homeusersInfo;
}

//listo
Future<Map<String, List<dynamic>>> getUsersHouse(int idCasa) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT * FROM SOFIDBA_02.V_HOMEUSER WHERE ID_CASA = $idCasa");
  Map<String, List<dynamic>> homeInfo = {};
  String name;

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (jsonResponse['OK'] != null && jsonResponse['OK'].isNotEmpty) {
        for (var userHomeArray in jsonResponse['OK']) {
          if (userHomeArray is List && userHomeArray.length == 7) {
            // obtener la lista
            name = "${userHomeArray[1]} ${userHomeArray[2]} ${userHomeArray[3]}";
            List<dynamic> valueslist = [];
            valueslist.add([userHomeArray[4], userHomeArray[5], userHomeArray[6]]);
            homeInfo[name] = valueslist;
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  print(homeInfo);
  return homeInfo;
}


//listo
Future<Map<String, int>> getRolTypes() async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT * FROM SOFIDBA_02.TIPOROL");
  Map<String, int> rolMap = {};

  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var ladaPair in jsonResponse['OK']) {
          if (ladaPair is List && ladaPair.length == 2) {
            String rol = ladaPair[0];
            int primaryKey = ladaPair[1]; // la clave primaria
            rolMap[rol] = primaryKey;
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }

  return rolMap;
}


Future<void> updateInfoRoles(Map<String,List<dynamic>> usersFromHouse) async{

    var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql");

    for (var user in usersFromHouse.entries) {
      print("${user.key}: nuevo rol: ${user.value[0][0]}, id rol: ${user.value[0][1]}");
      int cveRol = user.value[0][1];
      int idPersona = user.value[0][2];
      Map<String,dynamic> userJSON ={
        "crud": "UPDATE",
        "data": {
          "PERSONA":{
              "cve_tiporol": cveRol,
              "where" : "id_persona = $idPersona"
          }
        }
      };
      String body = jsonEncode(userJSON);
      print(body);
      try {
        final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);

        if (response.statusCode == 200) {
          print(response);
          } else {
            print('Request failed with status: ${response.statusCode}.');
          }

      } catch (e) {
          print('An error occurred: $e');
      }
    }
}