import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DataRead extends StatefulWidget {
  const DataRead({super.key});
  @override
  State<DataRead> createState() => _DataReadState();
}

class _DataReadState extends State<DataRead> {
  
  String displayText = 'Results go here';
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Ultima_temperatura');
  
  @override
  void initState(){
    super.initState();
    _activeListeners();
  }

  void _activeListeners() {
    reference.onValue.listen((event) {
      final temperatura = event.snapshot;
      setState(() {
        displayText = temperatura.child('temperatura').value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:15.0),
          child: Column(
            children: [
              Text('Temperatura: $displayText'),
            ],
            )
        )
      ) 
    );
  }
}