import 'package:flutter/material.dart';
import 'package:proyectoiot/services/auth.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/images_icons/register_icon.dart';

//------------------------------------------------------------
//Pantalla para registrarse en la aplicación/Firebase
//------------------------------------------------------------


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
  String nombre = '';
  String apm = '';
  String app = '';
  int edad = 0;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Color(0xFF0f1b35),
        elevation: 0.0,
        title: const Text('Register'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: Color(0xFFE9EEF0)),
            label : const Text(
              'LogIn',
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
              registerIcon,
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Nombre'),
                validator: (val) => val!.isEmpty ? 'Complete the field' : null,
                onChanged: (val){
                  setState(() => nombre = val);
                }
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 -20, // La mitad del ancho de la pantalla con un pequeño espacio de separación
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Apellido Paterno'),
                      validator: (val) => val!.isEmpty ? 'Complete the field' : null,
                      onChanged: (val) {
                        setState(() => app = val);
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 -20, // La mitad del ancho de la pantalla con un pequeño espacio de separación
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Apellido Materno'),
                      validator: (val) => val!.isEmpty ? 'Complete the field' : null,
                      onChanged: (val) {
                        setState(() => apm = val);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Edad'),
                keyboardType: TextInputType.number,
                validator: (val){
                    if (val!.isEmpty) {
                      return 'Complete the field';
                    }
                    if (!isNumeric(val)) {
                      return 'Ingrese solo números';
                    }
                    return null; // Devuelve null si no hay errores de validación
                  },
                onChanged: (val){
                  setState(() => edad = int.parse(val));
                }
              ),
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
                style: ElevatedButton.styleFrom(backgroundColor:  Color(0xFF767674)),
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

bool isNumeric(String value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}
