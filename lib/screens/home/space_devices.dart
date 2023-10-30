import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:proyectoiot/shared/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: reference.child("Casa/${widget.space}").onValue,
      builder: (context, snapshot){
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if(!snapshot.hasData){
          return const Center(child: Text('Cargando...'));
        } 

        final tilesList = <ListTile>[];
        final DatabaseEvent event = snapshot.data!;
        final Map<String, dynamic> garageData = (event.snapshot.value as Map<dynamic, dynamic>).cast<String, dynamic>();
        final Map<String, dynamic> devices = {};
        
        garageData.forEach((key, value) {
          final deviceState = (value as Map<dynamic, dynamic>)['estado'];
          devices[key] = deviceState;
        }); 

        devices.forEach((key, value) {
        bool status;
        status = value;  // Itera sobre el mapa devices en lugar de garageData
        final devicesTile = ListTile(
          title: Text(key,style: const TextStyle(color: color_0, fontSize: 20),),
          trailing: SwitchDevices(
            isSwitched: status, 
            onChanged: (value) {
              setState(() {
                status = value;
              });
              reference.child("Casa/${widget.space}/$key").set({'estado': status});
            },
          ),  // Muestra el nombre del dispositivo, un switch y su estado
        );
        tilesList.add(devicesTile);
        });

        return ListView(
            children: tilesList,
        );
      }
    );
  }
}