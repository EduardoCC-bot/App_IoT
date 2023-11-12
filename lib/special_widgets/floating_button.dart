import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/special_widgets/add_device.dart';

// ignore: camel_case_types
class AddAreaDevice extends StatelessWidget {
  final BuildContext context;

  const AddAreaDevice({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
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
                      child: const Text('Añadir un área', style: TextStyle(color: color_0)),
                       onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddDevice();
                          },
                        );
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    divider,
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
                    ),
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