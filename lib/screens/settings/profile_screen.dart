import 'package:proyectoiot/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/user_icon.dart';
import 'package:provider/provider.dart';
import '/models/user_model.dart';
import 'package:http/http.dart';
import 'dart:convert';


//valores que obtendremos al hacer la conexion con la base de datos

String url = 'http://apihomeiot.online/v1.0/db';


void getResp() async{
    //http://apihomeiot.online/v1.0/db
    url = '$url/db=SQL&crud=SELECT&data="SELECT * FROM LADA"';
    Response response = await get(Uri.parse(url));
    Map data =  jsonDecode(response.body);
    // ignore: avoid_print
    print(data);
}


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen> {
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
                        
                   ListTile(
                      leading: const Icon(Icons.edit_square, color: color_11),
                      title: const Text(
                      'Cambiar Datos',
                      ),
                      onTap: () {setState(() { cambio = !cambio; });},
                    )
                  ],
          ),
        ),
    );

  }
}
