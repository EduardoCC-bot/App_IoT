import 'package:flutter/material.dart';
import 'package:proyectoiot/services/auth.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/shared/loading.dart';
import 'package:proyectoiot/images_icons/logo_icon.dart';

//------------------------------------------------------------
//Pantalla para logearse en la aplicación/Firebase
//------------------------------------------------------------

class LogIn extends StatefulWidget {

  final Function? toggleView;
  const LogIn({Key? key, this.toggleView}): super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //estado del campo de texto
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Color(0xFF0f1b35),
        elevation: 0.0,
        title: const Text('LogIn'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: Color(0xFFE9EEF0)),
            label : const Text(
              'Register',
              style: TextStyle(color: Color(0xFFE9EEF0))
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
          key: _formKey,
          child: Column(
            children: <Widget>[
              logoIcon,
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);
                }
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ characters long' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                }
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF767674)),
                child: const Text(
                  'LogIn',
                  style: TextStyle(color: Colors.white),
                  ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.logInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() => loading = false);
                      setState(() => error = 'Could not log in with those credentials.');
                    }
                  }
                },
                ),
                const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red)
                )
            ],
          )
        )
      ),
    );
  }
}