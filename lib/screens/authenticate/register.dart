import 'package:flutter/material.dart';
import 'package:proyectoiot/services/auth.dart';
import 'package:proyectoiot/shared/constants.dart';

class Register extends StatefulWidget {

  final Function? toggleView;
  const Register({Key? key, this.toggleView}): super(key: key);
  
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //estado de campo de texto
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Register'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: Colors.black),
            label : const Text(
              'LogIn',
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
          key: _formKey,
          child: Column(
            children: <Widget>[
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                  ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Please supply a valid email.';
                        loading = false;
                        });
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