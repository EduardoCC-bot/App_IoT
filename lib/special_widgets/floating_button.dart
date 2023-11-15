import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/models/house_info.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/special_widgets/add_something.dart';
import '../../models/user_info.dart';


// ignore: camel_case_types
class AddAreaDevice extends StatelessWidget {
  final BuildContext context;

  const AddAreaDevice({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    UserInfo userInfo = Provider.of<UserInfo>(context); 
    HouseInfo houseInfo = Provider.of<HouseInfo>(context); // Obteniendo HouseInfo
    return FloatingActionButton(
      foregroundColor: colorBlanco,
      backgroundColor: color_1,
      elevation: 5.0,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Elige una opción", style: TextStyle(color: color_0),),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text('Añadir un dispositivo', style: TextStyle(color: color_0)),
                       onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddSomething(pkCasa: houseInfo.idCasa, houseName: userInfo.casa!);
                          },
                        );
                      },
                    ),
                    //const Padding(padding: EdgeInsets.all(8.0)),
                    /*divider,
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: const Text('Añadir un dispositivo', style: TextStyle(color: color_0)),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddDevice();
                          },
                        );
                      },
                    ),*/
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}