import 'package:proyectoiot/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/user_icon.dart';
import 'package:provider/provider.dart';
import '/models/user_model.dart';
import 'package:http/http.dart';
import 'dart:convert';


//valores que obtendremos al hacer la conexion con la base de datos
String nombre = 'Nombre';
String apellidoP = 'Apellido Paterno';
String url = 'http://onlyalecserver.ddns.net';
String apellidoM = 'Apellido Materno';
int edad = 20;
bool cambio = false;
Map info = {};  



void getResp() async{
    Response response = await get(Uri.parse(url));
    Map data =  jsonDecode(response.body);
    print(data);
}


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {


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
              
              SizedBox(height: 16.0),
              
              Text(nombre),
              TextField(
              controller: TextEditingController(text: nombre),
              enabled: false,
              ),
              SizedBox(height: 16.0),

              Text('Apellido Paterno:'),
                TextField(
                  controller: TextEditingController(text: apellidoP),
                  enabled: cambio,
                ),

                SizedBox(height: 16.0),

                Text('Apellido Materno:'),
                TextField(
                  controller: TextEditingController(text: apellidoM),
                  enabled: cambio,
                ),
                SizedBox(height: 16.0),

                Text('Edad:'),
                TextField(
                  controller: TextEditingController(text: edad.toString()),
                  enabled: cambio,
                ),
                SizedBox(height: 16.0),

                Text('Correo:'),
                TextField(
                  controller: TextEditingController(text: 'correo'),
                  enabled: cambio,
                ),
                Text('Rol:'),
                TextField(
                  controller: TextEditingController(text: 'rol'),
                  enabled: cambio,
                ),
                Text('Nombre de la Casa:'),
                TextField(
                  controller: TextEditingController(text: 'nombreCasa'),
                  enabled: cambio,
                ),
                SizedBox(height: 16.0),

                ElevatedButton(onPressed: () async {
                  //Corregir el como recibe los datos 
                  //info = getResp();
                  cambio = true;
                  
                },
                    child: const ListTile(
                      leading: Icon(Icons.edit_square, color: color_11),
                      title: Text(
                      'Cambiar Datos',
                      ),
                    )
                  ),
              ],
          ),
        ),
    );
  }
}
