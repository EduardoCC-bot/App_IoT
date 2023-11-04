import 'package:flutter/material.dart';
import 'package:proyectoiot/services/auth.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/screens/loading.dart';
import 'package:proyectoiot/images_icons/login_icon.dart';

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
      backgroundColor: colorBlanco,
      appBar: AppBar(
        backgroundColor: color_1,
        elevation: 5.0,
        title: const Text('Acceder', style: TextStyle(color: colorBlanco),),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: colorBlanco),
            label : const Text(
              'Registrarse',
              style: TextStyle(color: colorBlanco)
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
          child: SingleChildScrollView(
            child: Column(
            children: <Widget>[
              loginIcon,
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Correo electrónico'),
                validator: (val) => val!.isEmpty ? 'Inserte un correo electrónico' : null,
                onChanged: (val){
                  setState(() => email = val);
                }
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Contraseña'),
                validator: (val) => val!.length < 6 ? 'Debe contener 6 o más carácteres' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                }
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: color_11),
                child: const Text(
                  'Acceder',
                  style: TextStyle(color: colorBlanco),
                  ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.logInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() => loading = false);
                      setState(() => error = 'No se pudo acceder con esas credenciales');
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
        )
      ),
    );
  }
}