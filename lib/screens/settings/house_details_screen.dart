// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:proyectoiot/images_icons/join_icon.dart';
import 'package:proyectoiot/screens/loading.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/sql_functions.dart';
import 'package:proyectoiot/shared/widget_functions.dart';
import '../../models/house_info.dart';
import '../../models/user_info.dart';
import 'package:proyectoiot/special_widgets/dropdown_button.dart';

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
  
  late Map<String,int> rolTypesMap;
  List<String>? rolTypes =[];
  
  bool loading = true;
  bool cambio = false;
  Map inforol = {};  


  @override
  void initState() {
    cambio = false;
    super.initState();
    initRolTypesMap();
  }

  void initRolTypesMap() async {
    rolTypesMap = await getRolTypes();
    setState(() {
      rolTypes = rolTypesMap.keys.map((key) => key.toString()).toList();
      if(rolTypes!.isNotEmpty) {
        loading = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
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
              //Imagen de casa,
              Center(
                child: joinIcon,
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
                    String userName = entry.key;
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(text: userName),
                            decoration: const InputDecoration(labelText: 'Nombre'),
                            enabled: false,
                          ),
                        ),
                        const SizedBox(width: 10), // Espacio entre el TextField y el DropdownButton
                        Expanded(
                          child: 
                            dropDownOptions((newValue) { 
                              setState(() {
                                entry.value[0][0] = newValue;
                                entry.value[0][1] = (rolTypes!.isNotEmpty && newValue != null ? rolTypesMap[newValue] : null);
                            });
                            print(widget.house.integrantesRol!);
                          }, 
                          rolTypes!, 
                          entry.value[0][0], 
                          "ROL")
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
                        enabled: cambio,
                        tileColor: color_5,
                        title: const Text('Confirmar cambios', style:  TextStyle(color: color_0)),
                        leading: const Icon(Icons.save_as, color: color_11),
                        onTap: () async {
                          setState(() {loading = true;});
                          await updateNoSQLName(widget.house.nombreNoSQL!,replaceSpaces( widget.user.casa!));
                          await widget.house.noSQLName(replaceSpaces( widget.user.casa!));
                          await updateInfoRoles(widget.house.integrantesRol!);
                          setState(() {cambio = !cambio; loading = false;});
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

  Future<void> updateNoSQLName(String newName, String pathHouse) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(pathHouse); // Asegúrate de especificar la ruta correcta
    await ref.update({"nombre": newName,});
  }

}
