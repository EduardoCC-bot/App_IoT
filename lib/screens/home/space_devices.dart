import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/shared/widget_functions.dart';
import '../../models/user_info.dart';
import '../../special_widgets/switch.dart';

//----------------------------------------------------------------------
//Contiene la lógica utilizada para la modificación de estados de los dispositivos 
//----------------------------------------------------------------------

class DevicesInASpace extends StatefulWidget {
  const DevicesInASpace({super.key, required this.space});
  final String space;

  @override
  State<DevicesInASpace> createState() => _DevicesInASpace();
}

class _DevicesInASpace extends State<DevicesInASpace> {

  final DatabaseReference reference = FirebaseDatabase.instance.ref();
  String path='';

  @override
  Widget build(BuildContext context) {
    UserInfo userInfo = Provider.of<UserInfo>(context, listen: false);
    path = replaceSpaces(userInfo.casa!);
    return StreamBuilder<DatabaseEvent>(
      stream: reference.child("$path/Espacios/${widget.space}/Dispositivos").onValue,
      builder: (context, snapshot){
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if(!snapshot.hasData){
          return const Center(child: Text(''));
        }
        if(snapshot.data!.snapshot.value == null){
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.emoji_objects, color: color_11,size: 40),
              SizedBox(height: 20,),
              Text('No hay nada que hacer por aquí', style: TextStyle(color: color_0, fontSize: 15))
            ],
          );
        } 

        final DatabaseEvent event = snapshot.data!;
        final Map<String, dynamic> deviceData = (event.snapshot.value as Map<dynamic, dynamic>).cast<String, dynamic>();
        final Map<String, dynamic> devices = {};

        deviceData.forEach((key, value) {
            final deviceState = (value as Map<dynamic, dynamic>)['estado'];
            devices[key] = deviceState;
        });

        return ListView.builder(
          itemCount: devices.length * 2 + 1,  // Añade 1 al itemCount para el Divider al inicio
          itemBuilder: (context, index) {
              if (index == 0) {
                  return const Divider();  // Si index es 0, retorna un Divider
              }
              final adjustedIndex = index - 1;  // Ajusta el index para compensar el Divider al inicio
              if (adjustedIndex.isEven) {  // Si el índice ajustado es par, construye un ListTile
                  final deviceKey = devices.keys.elementAt(adjustedIndex ~/ 2);
                  bool status = devices[deviceKey];
                  String deviceKeywithSpaces = replaceUnderscore(deviceKey);
                  return ListTile(
                      title: Text(
                          deviceKeywithSpaces,
                          style: const TextStyle(color: color_0, fontSize: 20),
                      ),
                      trailing: SwitchDevices(
                          isSwitched: status,
                          onChanged: (value) {
                              setState(() {
                                  status = value;
                              });
                              reference.child("$path/Espacios/${widget.space}/Dispositivos/$deviceKey").update({'estado': status});
                              reference.child("$path/Espacios/${widget.space}/Ultimo_modificado").update({'dispositivo': deviceKey,'estado': status});
                          },
                      ),
                  );
              } else {  // Si el índice ajustado es impar, construye un Divider
                  return const Divider();
              }
            },
        );
      }
    );
  }
}