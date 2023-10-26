import 'package:flutter/material.dart';
import 'package:proyectoiot/services/auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      drawer:  Drawer(
        child:  Container(
          color: Color(0xFF0f1b35),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), // Ajusta el valor según el radio de curvatura que desees
                  child: Container(
                    color: Color(0xFFffffff), // Color de fondo
                    child: Center(
                      child: Image.network("https://cdn-icons-png.flaticon.com/512/2910/2910721.png"),
                    ),
                  ),
                ),
              ),
              const Text("USUARIO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFFffffff) ),),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: Color(0xFFadd6f2),
                child: const Text("Notificaciones", style: TextStyle(color: Color(0xFFffffff)),),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: Color(0xFFadd6f2),
                child: const Text("Configuracion", style: TextStyle(color: Color(0xFFffffff)),),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: Color(0xFFadd6f2),
                child: const Text("Cerrar Secion", style: TextStyle(color: Color(0xFFffffff)),),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('HOME'),
        backgroundColor: Color(0xFF0f1b35),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: Color(0xFF192e5b)),
            label: const Text('logout', style: TextStyle(color: Color(0xFF192e5b))),
            onPressed: () async {
              await _auth.signOut();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF8e0c48)),
            ),
          ),
        ],
      ),
    );
  }
}