import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/join_house.dart';
import 'package:proyectoiot/images_icons/login_icon.dart';
import '../../../models/registry.dart';
import '../../../services/auth.dart';
import '../../../shared/constants.dart';
import '../../../shared/functions.dart';
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

  String houseName = '';
  String housePassword = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() :Scaffold(
      backgroundColor: colorBlanco,
      appBar: AppBar(
        backgroundColor: color_1,
        elevation: 5.0,
        title: const Text('Únete'),
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
                      child: formBox('Nombre de la casa', 'Complete el campo', context,(val) => setState(() => houseName = val)),
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
                        setState(() => housePassword = val);
                       }
                      )
                      ),
                 ]
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color_11),
                  child: const Text(
                    'Unirse',
                    style: TextStyle(color: colorBlanco),
                    ),
                   onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(widget.registry.email, widget.registry.password);
                      if(result != null){
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      }
                    }
                   }
                  )
                ]
                ),
//-------------------------------------------------------------------------------------------------------------------                
            )
          )
        )
      );
  }
}