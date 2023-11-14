// ignore_for_file: avoid_print
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/registry.dart';

//listo
Future<Map<int, int>> getLada() async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20*%20FROM%20Lada");
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
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20e.descripcion,e.id_tipoestado,%20p.descripcion%20FROM%20TipoEstado%20e,%20TipoPais%20p,%20Lada%20l%20WHERE%20l.codigo%20=%20$lada%20AND%20l.cve_tipoestado%20=%20e.id_tipoestado%20AND%20e.cve_tipopais%20=%20p.id_tipopais");
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
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20*%20FROM%20Tipopropiedad");
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
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT COUNT(*) FROM Casa WHERE casa.descripcion = '$houseName'");
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
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT n.nombre, n.apellido_paterno, n.apellido_materno, p.edad, p.correo, r.descripcion, c.descripcion, p.uid_db, c.id_casa, (SELECT COUNT(*) FROM Espacio WHERE Espacio.cve_casa = c.id_casa) FROM Nombre n, Persona p, TipoRol r, Casa c WHERE n.id_nombre = p.cve_nombre AND r.id_tiporol = p.cve_tiporol AND c.id_casa = p.cve_casa AND p.uid_db = '$uid'");
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
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20id_casa%20FROM%20Casa%20WHERE%20casa.descripcion%20=%20%27${registry.houseDescription}%27%20AND%20casa.contrasenia%20=%20STANDARD_HASH(%27${registry.housePassword}%27,%20%27SHA256%27)");
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

Future<List<String>> getAreaTypes(int lada) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/db?db=SQL&crud=SELECT&data=SELECT%20te.descripcion%20FROM%20TipoEspacio%20te");
  List<String> areaTypes = [];
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var data in jsonResponse['OK']) {
          if (data is List && data.isNotEmpty) {
            areaTypes.add(data.toString());
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  print(areaTypes);
  return areaTypes;
}

Future<List<String>> getDeviceTypes(int lada) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/db?db=SQL&crud=SELECT&data=SELECT%20te.descripcion%20FROM%20TipoEspacio%20te");
  List<String> deviceTypes = [];
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var data in jsonResponse['OK']) {
          if (data is List && data.isNotEmpty) {
            deviceTypes.add(data.toString());
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  print(deviceTypes);
  return deviceTypes;
}