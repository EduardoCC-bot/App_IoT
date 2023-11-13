import 'package:flutter/material.dart';
import 'package:proyectoiot/images_icons/join_icon.dart';
import 'package:proyectoiot/models/registry.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/shared/sql_functions.dart';
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

  late Map<String,int> houseTypesMap;
  List<String>? houseTypes=[];


  bool loading = true;
  String error = '';

  void initHouseTypesMap() async {
    houseTypesMap = await getHouseTypes();
    setState(() {
    houseTypes = houseTypesMap.keys.toList();
    if(houseTypes!.isNotEmpty) {
      widget.registry.houseType = houseTypes!.first;
      widget.registry.pkHouseType= (houseTypes!.isNotEmpty ? houseTypesMap[houseTypes!.first] : null);
      loading = false;
    }
   });
  }

  @override
  void initState() {
    super.initState();
    initHouseTypesMap();
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
                        (newValue) {
                          setState(() {
                            widget.registry.houseType = newValue; // Actualizar el valor seleccionado
                            widget.registry.pkHouseType= (houseTypes!.isNotEmpty && newValue != null ? houseTypesMap[newValue] : null); // Actualizar el valor asociado del mapa
                          });
                        },
                        houseTypes!,
                        widget.registry.houseType,
                        "Selecciona el tipo de propiedad" // Etiqueta para el dropdown
                      )
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
                    if (_formKey.currentState!.validate()){
                      //rol de propietario
                      widget.registry.pkRol = 1;

                      //pone pantalla de carga
                      setState(() => loading = true);   
                     
                      //hace el registro de usuario en firebase
                      dynamic result = await _auth.registerWithEmailAndPassword(widget.registry);                  
                      //si el registro fue exitoso, inserta los datos en la SQL
                      if(result == null){
                        setState(() => loading = false);
                        setState(() => error = 'No se pudo registrar con este correo electrónico');
                      }else{
                        if(widget.registry.pkHouseType != null){
                        await createHouse(widget.registry);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        }else{
                          setState(() => error = 'Selecciona un tipo de propiedad');
                        }
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