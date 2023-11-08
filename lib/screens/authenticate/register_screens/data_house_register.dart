import 'package:flutter/material.dart';
import 'package:proyectoiot/models/registry.dart';
import 'package:proyectoiot/screens/authenticate/register_screens/create_house.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/shared/functions.dart';
import 'package:proyectoiot/special_widgets/dropdown_button.dart';

//------------------------------------------------------------
//Pantalla para registrar los datos de la Casa
//------------------------------------------------------------


// ignore: must_be_immutable
class HouseRegistry extends StatefulWidget {
  Registry registry;
  HouseRegistry({super.key, required this.registry});
  
  @override
  State<HouseRegistry> createState() => _HouseRegistryState();
}

class _HouseRegistryState extends State<HouseRegistry> {

  final _formKey = GlobalKey<FormState>();

  List<String> states = ['Estado 1', 'Estado 2', 'Estado 3', 'Estado 4'];
  List<String> countries = ['País 1', 'País 2', 'País 3', 'País 4'];
  String? selectedCountry, selectedState;

  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlanco,
      appBar: AppBar(
        backgroundColor: color_1,
        elevation: 5.0,
        title: const Text('Datos de la casa'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
//-------------------------------------------------------------------------------------------------------------------                
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children:[
                    Flexible(
                      flex: 3,
                      child: dropDownOptions(
                        (String? newValue) {
                        setState(() {
                          widget.registry.country = newValue!;
                          selectedCountry = newValue;
                        });
                      }, countries, selectedCountry ?? countries.first, 'País')
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      flex: 5,
                      child: dropDownOptions(
                        (String? newValue) {
                        setState(() {
                          widget.registry.state = newValue!;
                          selectedState = newValue;
                        });
                      }, states, selectedState ?? states.first, 'Estado')
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
                      child: formBox('Municipio', 'Complete el campo', context, (val) => setState(() => widget.registry.municipality = val)),
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
                      child: formBox('Colonia', 'Complete el campo', context, (val) => setState(() => widget.registry.colony = val)),
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
                        child: formBox('Calle', 'Complete el campo', context, (val) => setState(() => widget.registry.street = val)),
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
                          decoration: textInputDecoration.copyWith(hintText: 'Núm. Ext.'),
                          keyboardType: TextInputType.number,
                          validator: (val){
                              if (val!.isEmpty) {return 'Complete el campo';}
                              if (!isNumeric(val)) {return 'Solo números';}
                              if (val.length>4) {return 'Longitud no válida';}
                              return null; // Devuelve null si no hay errores de validación
                          },
                          onChanged: (val) {
                            setState(() {
                              try {
                                widget.registry.extNum = val;
                              } catch (e) {
                                // ignore: avoid_print
                                print('Ingresa solo números');
                          }
                          });
                        },
                      )
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Núm. Int.'),
                        keyboardType: TextInputType.number,
                        validator: (val){
                            if (val!.isEmpty) {return 'Complete el campo';}
                            if (!isNumeric(val)) {return 'Solo números';}
                            if (val.length>4) {return 'Longitud no válida';}
                            return null; // Devuelve null si no hay errores de validación
                        },
                        onChanged: (val) {
                          setState(() {
                            try {
                              widget.registry.intNum = val;
                            } catch (e) {
                              print('Ingresa solo números');
                            }
                          });
                        },
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
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Código Postal'),
                        keyboardType: TextInputType.number,
                        validator: (val){
                            if (val!.isEmpty) {return 'Complete el campo';}
                            if (!isNumeric(val)) {return 'Solo números';}
                            if (val.length!=5) {return 'Longitud no válida';}
                            return null; // Devuelve null si no hay errores de validación
                        },
                        onChanged: (val) {
                          setState(() {
                            try {
                              widget.registry.cp = val;
                            } catch (e) {
                              print('Ingresa solo números');
                            }
                          });
                        },
                      )
                    ),
                  ]
                ),
//-------------------------------------------------------------------------------------------------------------------                             
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: color_11),
                  child: const Text('Continuar',style: TextStyle(color: colorBlanco),),
                  onPressed:  () {
                  if (_formKey.currentState!.validate()){
                        Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateHouse(registry: widget.registry),
                      ));
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