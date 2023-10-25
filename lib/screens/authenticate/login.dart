import 'package:flutter/material.dart';
import 'package:proyectoiot/services/auth.dart';

class LogIn extends StatefulWidget {

  final Function? toggleView;
  const LogIn({Key? key, this.toggleView}): super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final AuthService _auth = AuthService();

  //estado del campo de texto
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('LogIn'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: Colors.black),
            label : const Text(
              'Register',
              style: TextStyle(color: Colors.black)
            ),
            onPressed: () {
              widget.toggleView!();
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Form(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                onChanged: (val){
                  setState(() => email = val);
                }
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                }
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text(
                  'LogIn',
                  style: TextStyle(color: Colors.white),
                  ),
                onPressed: () async {

                },
                )
            ],
          )
        )
      ),
    );
  }
}