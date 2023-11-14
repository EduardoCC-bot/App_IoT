import 'package:proyectoiot/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/login_Icon.dart';
import 'package:provider/provider.dart';
import '/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//valores que obtendremos al hacer la conexion con la base de datos



Future<List<int>> getLada() async {
  var url = Uri.parse("https://apihomeiot.online/v1.0/db?db=SQL&crud=SELECT&data=SELECT%20*%20FROM%20Lada");
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
}




class HouseDetailsScreen extends StatefulWidget {
  const HouseDetailsScreen({super.key});

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
    final user = Provider.of<UserModel?>(context);
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
              controller: TextEditingController(text: user!.nombre),
              enabled: cambio,
              ),
              const SizedBox(height: 16.0),

              const Text('Apellido Paterno:'),
                TextField(
                  controller: TextEditingController(text: user.apellidoPaterno),
                  enabled: cambio,
                ),

                const SizedBox(height: 16.0),

                const Text('Apellido Materno:'),
                TextField(
                  controller: TextEditingController(text: user.apellidoMaterno),
                  enabled: cambio,
                ),
                const SizedBox(height: 16.0),

                const Text('Edad:'),
                TextField(
                  controller: TextEditingController(text: user.edad.toString()),
                  enabled: cambio,
                ),
                const SizedBox(height: 16.0),

                const Text('Correo:'),
                TextField(
                  controller: TextEditingController(text: user.correo),
                  enabled: cambio,
                ),
                const Text('Rol:'),
                TextField(
                  controller: TextEditingController(text: user.rol),
                  enabled: cambio,
                ),
                const Text('Nombre de la Casa:'),
                TextField(
                  controller: TextEditingController(text: user.casa),
                  enabled: cambio,
                ),
                const SizedBox(height: 16.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ajusta el alineamiento de los elementos
                  children: [
                    Expanded( // Para que ambos ListTiles ocupen el mismo espacio
                      child: ListTile(
                        tileColor: color_5,
                        title: Text('Cambiar infromacion', style:  TextStyle(color: color_0)),
                        leading: Icon(Icons.edit, color: color_11),
                        onTap: () {setState(() {
                           cambio = !cambio;
                            //getla();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        tileColor: color_5,
                        title: Text('Confirmar cambios', style:  TextStyle(color: color_0)),
                        leading: Icon(Icons.save_as, color: color_11),
                        onTap: () {
                          cambio = !cambio;
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
