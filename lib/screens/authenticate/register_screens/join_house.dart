import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/join_icon.dart';
import '../../../models/registry.dart';
import '../../../services/auth.dart';
import '../../../shared/constants.dart';
import '../../../shared/sql_functions.dart';
import '../../../shared/widget_functions.dart';
import '../../loading.dart';


// ignore: must_be_immutable
class JoinHouse extends StatefulWidget {

  Registry registry;
  JoinHouse({super.key, required this.registry});
  @override
  State<JoinHouse> createState() => _JoinHouseState();
}

class _JoinHouseState extends State<JoinHouse> {

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  int? credentialValidationResult;

  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() :Scaffold(
      backgroundColor: colorBlanco,
      appBar: AppBar(
        backgroundColor: color_1,
        elevation: 5.0,
        title: const Text('Únete a una casa'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                joinIcon,
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children:[
                    Flexible(
                      flex: 4,
                      child: formBox('Nombre de la casa', 'Complete el campo', context,(val) => setState(() => widget.registry.houseDescription = val)),
                    ),
                  ]
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children:[
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Contraseña de la casa'),
                      validator: (val) => val!.isEmpty ? 'Llene el campo' : null,
                      obscureText: true,
                      onChanged: (val){
                        setState(() => widget.registry.housePassword = val);
                       }
                      )
                      ),
                 ]
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color_11),
                  child: const Text('Unirse',style: TextStyle(color: colorBlanco)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.registry.pkRol = 2;

                      //pone pantalla de carga
                      setState(() => loading = true);

                      // Primero, verifica las credenciales de la casa
                      int credentialValidationResult = await verifyHouseCredentials(widget.registry);

                      // Procede solo si el resultado es 1
                      if (credentialValidationResult != 0) {
                        widget.registry.pkHouse = credentialValidationResult;
                        dynamic result = await _auth.registerWithEmailAndPassword(widget.registry);
                        if (result == null) {
                          // Si el registro falla, muestra un error
                          setState(() {
                            loading = false;
                            error = 'No se pudo registrar con este correo electrónico';
                          });
                        } else {
                          await joinHouse(widget.registry);
                          // Si el registro es exitoso, navega fuera
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        }
                      } else {
                        // Si la verificación de credenciales falla, muestra un mensaje adecuado
                        setState(() {
                          loading = false;
                          error = 'Credenciales de la casa inválidas';
                        });
                      }
                    }
                  }
                  ),
                if (error.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                ]
                ),
//-------------------------------------------------------------------------------------------------------------------                
            )
          )
        )
      );
  }
}