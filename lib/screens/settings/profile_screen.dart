import 'dart:io';
import 'package:flutter/services.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/user_icon.dart';
import 'package:provider/provider.dart';
import '/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//valores que obtendremos al hacer la conexion con la base de datos


void testGet() async{
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20*%20FROM%20persona");
  try {
    final respond = await http.get(url);
    print(respond.body);
  } catch (e) {
    print( e.toString());
  }  
}


void updateInfo(Map info) async{
  //UPDATE PERSONA
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=UPDATE");
  String jsonbody = json.encode(info);

  http.post(url,
  headers: <String, String>{
    'Content-Type': 'application/json',
    'Server': 'nginx/1.22.1',
    'Access-Control-Allow-Origin':'*',
    },
    body: jsonbody
  ).then((response){
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
  }).catchError( (error) {
      print('Error: $error');
  });
}


/*
Future<List<int>> getLada() async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT%20*%20FROM%20Lada");
  List<int> ladaList = [];
  try {
    //final response = await http.get(url);
      final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['OK'] != null) {
        /*for (var ladaPair in jsonResponse['OK']) {
          if (ladaPair is List && ladaPair.isNotEmpty) {
            ladaList.add(ladaPair[0] as int);
          }
        }*/
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
  //print(ladaList);
  return ladaList;
}*/






class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<int>> ladas; 
  bool cambio = false;
  Map<String, dynamic> info = {};  
  
  @override
  void initState() {
    cambio = false;
    super.initState();
    //getResp();
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
          centerTitle: true,
          backgroundColor: color_1,
          elevation: 5.0,

      ),
      body: 
        SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image.network('src'),
              Center(
                child: userIcon,
              ),
              const SizedBox(height: 16.0),
              
              const Text('Nombre'),
              TextField(
                controller: TextEditingController(text: user!.nombre),
                enabled: cambio,
                onChanged: (value) {
                  user.nombre= value;
                },
              ),
              const SizedBox(height: 16.0),

              const Text('Apellido Paterno:'),
                TextField(
                  controller: TextEditingController(text: user.apellidoPaterno),
                  enabled: cambio,
                onChanged: (value) {
                  user.apellidoPaterno = value;
                },

                ),

                const SizedBox(height: 16.0),

                const Text('Apellido Materno:'),
                TextField(
                  controller: TextEditingController(text: user.apellidoMaterno),
                  enabled: cambio,
                  onChanged: (value) {
                  user.apellidoMaterno = value;
                },
                ),
                const SizedBox(height: 16.0),

                const Text('Edad:'),
                TextField(
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                  controller: TextEditingController(text: user.edad.toString()),
                  enabled: cambio,
                  onChanged: (value) {
                  // Intentar convertir la cadena de texto a un entero
                  int? parsedValue = int.tryParse(value);

                  if (parsedValue != null) {
                    // Si la conversión es exitosa, asignar el valor a user.edad
                      user.edad = parsedValue;
                  } else {
                    // Manejar el caso en el que la entrada no sea un número válido
                    // Podrías mostrar un mensaje de error o tomar alguna acción específica
                    print("Valor nulo");
                    user.edad = 0;
                  }
                  print(parsedValue);
                },
                ),
                const SizedBox(height: 16.0),

                const Text('Correo:'),
                TextField(
                  controller: TextEditingController(text: user.correo),
                  enabled: cambio,
                onChanged: (value) {
                  user.correo = value;
                },
                ),
                const Text('Rol:'),
                TextField(
                  controller: TextEditingController(text: user.rol),
                  enabled: false,
                ),
                const Text('Nombre de la Casa:'),
                TextField(
                  controller: TextEditingController(text: user.casa),
                  enabled: false,
                ),
              const SizedBox(height: 16.0),
              
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ajusta el alineamiento de los elementos
                  children: [
                    Expanded( // Para que ambos ListTiles ocupen el mismo espacio
                      child: ListTile(
                        tileColor: color_5,
                        title: const Text('Cambiar infromacion', style:  TextStyle(color: color_0)),
                        leading: const Icon(Icons.edit, color: color_11),
                        onTap: () {setState(() {
                           cambio = !cambio;
                            testGet();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        tileColor: color_5,
                        title: const Text('Confirmar cambios', style:  TextStyle(color: color_0)),
                        leading: const Icon(Icons.save_as, color: color_11),
                        onTap: () {
                          cambio = !cambio;
                          int test = user.edad ?? 0;
                          print(user.edad);
                          print(test);
                          info = {
                            "crud": "UPDATE",
                            "data" : {
                                "Persona": {
                                    "edad" : test,
                                    "correo" : user.correo, 
                                    "where":"id_persona = 1"
                                }
                            }
                          };
                          updateInfo(info);
                        },  
                      ),
                    ),
                  ],
                ),
              ],
          ),
        ),
    );
  }
}
