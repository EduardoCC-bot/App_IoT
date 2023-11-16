import 'package:proyectoiot/screens/home/mainly_screen.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/login_Icon.dart';
import '../../models/house_info.dart';
import '../../models/user_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyectoiot/special_widgets/dropdown_button.dart';





void updateInfo(Map info) async{
  //UPDATE PERSONA
  var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql");
  String jsonbody = json.encode(info);
  print(jsonbody);
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

void updateInfoRoles(Map info, List<String>? cat) async{
  //UPDATE PERSONA
  //FUNCION GET
    int? id_nombre;
    print(info);
    print("aqui arriba es joven");
    info.forEach((nombreCompleto, value) async {
          List<String> partesNombre = nombreCompleto.split(" ");
          String nombre = partesNombre[0];
          String apellidoPaterno = partesNombre.length > 1 ? partesNombre[1] : "";
          String apellidoMaterno = partesNombre.length > 2 ? partesNombre[2] : "";
          String rolCambio = value;

        var url = Uri.parse("https://apihomeiot.online/v1.0/dbsql?crud=SELECT&data=SELECT ID_NOMBRE FROM SOFIDBA_02.NOMBRE WHERE Nombre = '${nombre}' AND apellido_paterno = '${apellidoPaterno}' AND apellido_materno = '${apellidoMaterno}'");
        try {
          final response = await http.get(url);
          if (response.statusCode == 200) {
            var jsonResponse = json.decode(response.body);
            if (jsonResponse['OK'] != null) {
              for (var pair in jsonResponse['OK']) {
                if (pair is List && pair.length == 1) {
                    id_nombre = pair[0];
                    print(id_nombre);
                }
              }
            }
          } else {
            print('Request failed with status: ${response.statusCode}.');
          }
        } catch (e) {
          print('An error occurred: $e');
        }
         
          info = {
            "crud": "UPDATE",
            "data": {
                "PERSONA": {
                  "cve_tiporol" : cat!.indexOf(rolCambio) + 1 ,
                  "where" : "CVE_NOMBRE = $id_nombre"
                }
            }
          };
          url = Uri.parse("https://apihomeiot.online/v1.0/dbsql");
          String jsonbody = json.encode(info);
          print(jsonbody);
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
     });
}




//valores que obtendremos al hacer la conexion con la base de datos
// ignore: must_be_immutable
class HouseDetailsScreen extends StatefulWidget {
  HouseInfo house;
  UserInfo user;
  HouseDetailsScreen({super.key, required this.house, required this.user});

  @override
  State<HouseDetailsScreen> createState() => _HouseDetailsScreen();

}

class _HouseDetailsScreen extends State<HouseDetailsScreen> {
  late Future<List<int>> ladas; 
  bool cambio = false;
  Map inforol = {};  
  

  @override
  void initState() {
    cambio = false;
    super.initState();
    //getResp();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casa'),
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
                child: loginIcon,
              ),
        
              const SizedBox(height: 16.0),
              
              const Text('Nombre Casa'),
              TextField(
              controller: TextEditingController(text: widget.house.nombreNoSQL),
              enabled: cambio,
              onChanged: (value) {
                  widget.house.nombreNoSQL = value;
              },
              ),
              const SizedBox(height: 16.0),

              const Text('Direccion'),
                TextField(
                  maxLines: null,   
                  controller: TextEditingController(text: widget.house.direccion),
                  enabled: false,
                ),
                
                const SizedBox(height: 16.0),

                
                const Text('TIPO DE PROPIEDAD'),
                TextField(
                  controller: TextEditingController(text: widget.house.tipoCasa),
                  enabled: false,
                ),
                const SizedBox(height: 16.0),

                
                const Text('INTEGRANTES DE LA CASA'),
                const SizedBox(height: 16.0),

                Column(
                  children: widget.house.integrantesRol!.entries.map((entry) {
                    String clave = entry.key;
                    List lista = entry.value;
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(text: clave),
                            decoration: InputDecoration(labelText: 'Nombre'),
                            enabled: false,
                          ),
                        ),
                        SizedBox(width: 10), // Espacio entre el TextField y el DropdownButton
                        Expanded(
                          child: 
                            dropDownOptions((newValue) { 
                              setState(() {
                                lista[0][0] = newValue.toString();
                                inforol[clave] = lista[0][0];
                            });
                            }, widget.house.catrol!, lista[0][0], "ROL")
                        ),
                      ],
                    );
                  }).toList(),
                ),
                
              const SizedBox(height: 32.0),
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
                          Map info = {
                              "crud": "UPDATE",
                              "data": {
                                  "V_HOUSEDETALIS": {
                                      "descripcion": widget.house.nombreNoSQL,
                                      "where": "ID_CASA = ${widget.house.idCasa}"
                                  }
                              }
                          };
                          print(inforol);

                          updateInfo(info);
                          updateInfoRoles(inforol, widget.house.catrol);
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
