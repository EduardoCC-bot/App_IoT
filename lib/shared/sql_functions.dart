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
  print(ladaMap);
  return ladaMap;
}
//listo
Future<List<String>> getCountryState(int lada) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20e.descripcion,%20p.descripcion%20FROM%20TipoEstado%20e,TipoPais%20p,%20Lada%20l%20WHERE%20l.codigo%20=%20$lada%20AND%20l.cve_tipoestado=e.id_tipoestado%20AND%20e.cve_tipopais=p.id_tipopais%20GROUP%20BY%20e.descripcion,%20p.descripcion");
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
  print(countryState);
  return countryState;
}

Future<List<String>> getHouseTypes(int lada) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/db?db=SQL&crud=SELECT&data=SELECT%20*%20FROM%20TipoPropiedad");
  List<String> houseTypes = [];
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var data in jsonResponse['OK']) {
          if (data is List && data.isNotEmpty) {
            houseTypes.add(data.toString());
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  print(houseTypes);
  return houseTypes;
}

Future<void> insertAllSql(Registry registry) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/db");
  Map <String, dynamic> registryMap = registry.allDatatoJson();
  String body = jsonEncode(registryMap);
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
  print(flag);
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