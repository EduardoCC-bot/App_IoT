import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/choosing.dart';
import 'package:proyectoiot/models/registry.dart';
import 'package:proyectoiot/screens/authenticate/register_screens/data_house_register.dart';
import 'package:proyectoiot/screens/authenticate/register_screens/join_house.dart';
import 'package:proyectoiot/shared/constants.dart';

// ignore: must_be_immutable
class JoinOrCreate extends StatefulWidget {
  Registry registry;

  JoinOrCreate({super.key, required this.registry});

  @override
  State<JoinOrCreate> createState() => _JoinOrCreateState();
}

class _JoinOrCreateState extends State<JoinOrCreate> {

  Widget buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color_11,
        // Usar fixedSize para asegurarse de que todos los botones tengan el mismo tamaño
        fixedSize: const Size(200, 60), // Establecer el ancho y la altura
        textStyle: const TextStyle(fontSize: 20),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: colorBlanco),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlanco,
      appBar: AppBar(
        backgroundColor: color_1,
        elevation: 5.0,
        title: const Text('Crea o únete a una casa'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            choosingIcon,
            const SizedBox(height: 15),
            buildButton('Únete a una casa', () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => JoinHouse(registry: widget.registry),
              ));
            }),
            const SizedBox(height: 50),
            buildButton('Crea una casa', () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HouseRegistry(registry: widget.registry),
              ));
            }),
          ],
        ),
      ),
    );
  }
}