import 'package:flutter/material.dart';
import 'package:proyectoiot/services/auth.dart';

class Home extends StatelessWidget {
  
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        
      ),
      backgroundColor: Color(0xFFE9EEF0),
      appBar: AppBar(
        title: const Text('Inicio de la app'),
        backgroundColor: Color(0xFF393b3a),
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
    );
  }
}