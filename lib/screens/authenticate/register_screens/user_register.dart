import 'package:flutter/material.dart';
import 'package:proyectoiot/models/registry.dart';
import 'package:proyectoiot/screens/authenticate/register_screens/join_or_create.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/images_icons/register_icon.dart';
import 'package:proyectoiot/shared/widget_functions.dart';
import '../../../shared/sql_functions.dart';
import '../../../special_widgets/dropdown_button.dart';
import '../../loading.dart';

//------------------------------------------------------------
//Pantalla para registrarse en la aplicación/Firebase
//------------------------------------------------------------


class Register extends StatefulWidget {

  final Function? toggleView;
  const Register({super.key, this.toggleView});
  
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  late Map<int,int> ladasMap;
  List<String>? ladasKeys =[];

  //estado de campo de texto
  Registry registry = Registry();
  bool loading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    initLadasMap();
  }

   void initLadasMap() async {
    ladasMap = await getLada();
    setState(() {
    ladasKeys = ladasMap.keys.map((key) => key.toString()).toList();
    if(ladasKeys!.isNotEmpty) {
      registry.lada = ladasKeys!.first;
      registry.pkLada = (ladasKeys!.isNotEmpty ? ladasMap[int.parse(ladasKeys!.first)] : null);
      loading = false;
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: colorBlanco,
      appBar: AppBar(
        backgroundColor: color_1,
        elevation: 5.0,
        title: const Text('Registrarse'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: colorBlanco),
            label : const Text('Acceder',style: TextStyle(color: colorBlanco)),
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
                registerIcon,
//-------------------------------------------------------------------------------------------------------------------                
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children:[
                    Flexible(
                      flex: 4,
                      child: formBox('Nombre', 'Complete el campo', context,(val) => setState(() => registry.name = val)),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                        flex: 1,
                        child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Edad'),
                        keyboardType: TextInputType.number,
                        validator: (val){
                            if (val!.isEmpty) {return 'Complete el campo';}
                            if (!isNumeric(val)) {return 'Solo números';}
                            if (int.parse(val) >90 || int.parse(val) < 8 ) {return 'No es una edad válida';}
                            return null; // Devuelve null si no hay errores de validación
                        },
                        onChanged: (val) {
                          setState(() {
                            try {
                              registry.age = int.parse(val);
                            // ignore: empty_catches
                            } catch (e) {
                            }
                          });
                        },
                      )
                    )
                  ]
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: formBox('Apellido paterno', 'Complete el campo', context, (val) => setState(() => registry.app = val)),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      flex: 1,
                      child: formBox('Apellido materno', 'Complete el campo', context,(val) => setState(() => registry.apm = val)),
                    ),
                  ],
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 3,
                      child: dropDownOptions(
                        (newValue) {
                          setState(() {
                            registry.lada = newValue; // Actualizar el valor seleccionado
                            registry.pkLada = (ladasKeys!.isNotEmpty && newValue != null ? ladasMap[int.parse(newValue)] : null); // Actualizar el valor asociado del mapa
                          });
                        },
                        ladasKeys!,
                        registry.lada,
                        "Lada" // Etiqueta para el dropdown
                      )
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                        flex: 4,
                        child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Teléfono'),
                        keyboardType: TextInputType.number,
                        validator: (val){
                            if (val!.isEmpty) {return 'Complete el campo';}
                            if (!isNumeric(val)) {return 'Solo números';}
                            if(val.toString().length>8 || val.toString().length<7){return 'Longitud incorrecta';}
                            return null; // Devuelve null si no hay errores de validación
                        },
                        onChanged: (val) {
                          setState(() {
                            try {
                              registry.telephone = int.parse(val);
                            // ignore: empty_catches
                            } catch (e) {
                            }
                          });
                        },
                      )
                    )
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
                        decoration: textInputDecoration.copyWith(hintText: 'Correo Electrónico'),
                        validator: (val){
                            if (val!.isEmpty) {return 'Complete el campo';}
                            if (!isValidEmail(val)) {return 'Email no válido';}
                            return null; // Devuelve null si no hay errores de validación
                        },
                        onChanged:(val) {
                          setState(() => registry.email = val);
                        },
                      )
                    )
                  ]
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                    flex: 1,
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'Contraseña'),
                      validator: (val) => val!.length < 6 ? 'Debe contener 6 o más carácteres' : null,
                      obscureText: true,
                      onChanged: (val){
                        setState(() => registry.password = val);
                       }
                      )
                    )
                  ]
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color_11),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(color: colorBlanco),
                    ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => JoinOrCreate(registry: registry),
                      ));
                    }
                  }
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