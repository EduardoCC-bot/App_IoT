import 'package:proyectoiot/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/login_Icon.dart';
import 'package:provider/provider.dart';
import '/models/user_model.dart';
import '../../models/house_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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




//valores que obtendremos al hacer la conexion con la base de datos
// ignore: must_be_immutable
class HouseDetailsScreen extends StatefulWidget {
  HouseInfo house;
  HouseDetailsScreen({super.key, required this.house});

  @override
  State<HouseDetailsScreen> createState() => _HouseDetailsScreen();

}

class _HouseDetailsScreen extends State<HouseDetailsScreen> {
  late Future<List<int>> ladas; 
  bool cambio = false;
  Map info = {};  
  
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
                

                TextField(
                  controller: TextEditingController(text: "HACER EL DESPLEGABLE DE LAS LISTAS"),
                  enabled: cambio,
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
