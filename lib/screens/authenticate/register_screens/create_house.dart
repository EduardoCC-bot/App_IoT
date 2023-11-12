import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/join_icon.dart';
import 'package:proyectoiot/models/registry.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/shared/widget_functions.dart';
import 'package:proyectoiot/special_widgets/dropdown_button.dart';

import '../../../services/auth.dart';
import '../../loading.dart';

//------------------------------------------------------------
//Pantalla para crear una casa
//------------------------------------------------------------


// ignore: must_be_immutable
class CreateHouse extends StatefulWidget {
  Registry registry;
  CreateHouse({super.key, required this.registry});
  
  @override
  State<CreateHouse> createState() => _CreateHouseState();
}

class _CreateHouseState extends State<CreateHouse> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  List<String> houseTypes = ['Casa', 'Departamento', 'Dúplex', 'Cabaña'];
  String? selectedType;

  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() :Scaffold(
      backgroundColor: colorBlanco,
      appBar: AppBar(
        backgroundColor: color_1,
        elevation: 5.0,
        title: const Text('Crear casa'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20.0),
                joinIcon,
//-------------------------------------------------------------------------------------------------------------------                
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children:[
                    Flexible(
                      flex: 1,
                      child: dropDownOptions(
                        (String? newValue) {
                        setState(() {
                          widget.registry.houseType = newValue!;
                          selectedType = newValue;
                        });
                      }, houseTypes, selectedType ?? houseTypes.first, 'Tipo de casa')
                    ),
                  ]
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: formBox('Nombre de la casa', 'Complete el campo', context, (val) => setState(() => widget.registry.houseDescription = val)),
                    ),
                  ],
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Contraseña de la casa'),
                        validator: (val) => val!.length < 6 ? 'Debe contener 6 o más carácteres' : null,
                        obscureText: true,
                        onChanged: (val){
                          setState(() => widget.registry.housePassword = val);
                        }
                      ),
                    ),
                  ],
                ),
//-------------------------------------------------------------------------------------------------------------------                          
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color_11),
                  child: const Text('Continuar',style: TextStyle(color: colorBlanco),),
                  onPressed:  () async {
                    widget.registry.pkRol = 1;
                    if (_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(widget.registry);
                      if(result == null){
                        setState(() => loading = false);
                        setState(() => error = 'No se pudo registrar con este correo electrónico');
                      }else{
                        // ignore: use_build_context_synchronously
                        print(widget.registry);
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      }
                    }
                   }
                  ),
                  const SizedBox(height: 12.0),
                  Text(error, style: const TextStyle(color: Colors.red))
              ],
            )
          )
        )
      ),
    );
  }
}