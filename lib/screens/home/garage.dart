import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Garage extends StatefulWidget {
  const Garage({super.key});

  @override
  State<Garage> createState() => _GarageState();
}

class _GarageState extends State<Garage> {
  final DatabaseReference reference = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: reference.child("Casa/Garage").onValue,
      builder: (context, snapshot){
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if(!snapshot.hasData){
          return const CircularProgressIndicator();
        } 

        final tilesList = <ListTile>[];
        final DatabaseEvent event = snapshot.data!;
        final Map<String, dynamic> garageData = (event.snapshot.value as Map<dynamic, dynamic>).cast<String, dynamic>();
        
        final Map<String, dynamic> devices = {};
        garageData.forEach((key, value) {
          final deviceState = (value as Map<dynamic, dynamic>)['estado'];
          devices[key] = deviceState;
        }); 

        devices.forEach((key, value) {  // Itera sobre el mapa devices en lugar de garageData
        final devicesTile = ListTile(
          title: Text("$key: $value"),  // Muestra el nombre del dispositivo y su estado
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