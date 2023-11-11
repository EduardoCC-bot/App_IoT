import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/shared/widget_functions.dart';

//------------------------------------------------------------
//Pantalla y lógica para las notificaciones
//------------------------------------------------------------

class NotificationScreen extends StatefulWidget{
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  
  final DatabaseReference reference = FirebaseDatabase.instance.ref();

  //función encargada de eliminar notificaciones de la base de datos
  void deleteNotification(String key) {
  reference.child("Casa/Notificaciones").child(key).remove().then((_) {
    print("Notificación eliminada exitosamente");
  }).catchError((error) {
    print("Error al eliminar la notificación: $error");
  });
  }

  @override
  Widget build(BuildContext context){
    return StreamBuilder<DatabaseEvent>(
      stream: reference.child("Casa/Notificaciones").onValue,
      builder: (context, snapshot){
        //validaciones de data obtenida
        if(snapshot.hasError){
          return const Center(child: Text("Error al conectarse a la base de datos"));
        }
        if(!snapshot.hasData || snapshot.data!.snapshot.value == null){
          return const Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.done_all, color: color_2,size: 50),
                Text("No hay notificaciones por mostrar.", style: TextStyle(color: color_0,fontSize: 20))
              ],
            )
          ); 
        }

        final DatabaseEvent event = snapshot.data!;
        final Map<dynamic, dynamic> notificationsData = event.snapshot.value as Map<dynamic, dynamic>;
        final List<Widget> notificationList = [];

        //para cada notificación crea un Card con un ListTile dentro
        notificationsData.forEach((key, value) {
          List<String> dateAndHour = splitTimeStamp(key);
          final String mensaje = '${value['mensaje']}\nHora: ${dateAndHour[1]}\nFecha: ${dateAndHour[0]}';
          final String tipo = value['tipo'];
          notificationList.add(Card(
              color: color_5,
              elevation: 3.0,
              shadowColor: color_0,
              child: ListTile(
                title: Text(tipo, style: const TextStyle(color: color_10),),
                subtitle: Text(mensaje, style: const TextStyle(color: color_0)),
                leading: const Icon(Icons.warning, color: color_11, size: 40.0),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 30.0),
                  onPressed: () {
                    deleteNotification(key);// Llama a la función para borrar
                  },
                ),
              ),
            ),
          );
          notificationList.add(divider);  //añade un Divider entre los elementos
        });

        return ListView(
          children: notificationList,
        );
      },
    );
  }
}