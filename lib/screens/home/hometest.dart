import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/sensors_display.dart';
import 'package:proyectoiot/services/auth.dart';


class HomeTest extends StatefulWidget {
  const HomeTest({Key? key}) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeState();
}

class _HomeState extends State<HomeTest> {
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Inicio de la app'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: Colors.black),
            label: const Text('logout', style: TextStyle(color: Colors.black)),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      // ignore: prefer_const_constructors
      body: SensorDisplay(),
    );
  }
}