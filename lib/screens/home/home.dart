import 'package:flutter/material.dart';
import '../../special_widgets/drawer_menu.dart';

//------------------------------------------------------------
//HOME. Pantalla a la que se accede una vez autentificado
//------------------------------------------------------------

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      drawer:  drawer,
      appBar: AppBar(
        title: const Text('HOME'),
        backgroundColor: const Color(0xFF0f1b35),
        elevation: 0.0,
      ),
    );
  }
}