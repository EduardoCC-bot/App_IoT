import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/registry.dart';

Future<List<int>> getLada() async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/db?db=SQL&crud=SELECT&data=SELECT%20*%20FROM%20Lada");
  List<int> ladaList = [];
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var ladaPair in jsonResponse['OK']) {
          if (ladaPair is List && ladaPair.isNotEmpty) {
            ladaList.add(ladaPair[0] as int);
          }
        }
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  print(ladaList);
  return ladaList;
}



Future<List<String>> getCountryState(int lada) async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/db?db=SQL&crud=SELECT&data=SELECT%20e.descripcion,%20p.descripcion%20FROM%20TipoEstado%20e,TipoPais%20p,%20Lada%20l%20WHERE%20l.codigo%20=%20$lada%20AND%20l.id_lada=e.cve_estado%20AND%20e.cve_tipopais=p.id_tipopais%20GROUP%20BY%20e.descripcion,%20p.descripcion");
  List<String> countryState = [];
  try {
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        for (var data in jsonResponse['OK']) {
          if (data is List && data.isNotEmpty) {
            countryState.add(data.toString());
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
  Map <String, dynamic> registryMap = registry.toJson();
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
  var url = Uri.parse("https://apihomeiot.online/v1.0/db?db=SQL&crud=SELECT&data=SELECT%20COUNT%20(*)%20FROM%20Casa%20WHERE%20casa.descripcion%20=%20${registry.houseDescription}%20AND%20casa.contrasenia%20=%20STANDARD_HASH(${registry.housePassword},%20%27SHA256%27)");
  Map <String, dynamic> registryMap = registry.toJson();
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