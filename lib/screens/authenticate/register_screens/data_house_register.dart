import 'package:flutter/material.dart';
import 'package:proyectoiot/models/registry.dart';
import 'package:proyectoiot/screens/authenticate/register_screens/create_house.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/shared/widget_functions.dart';
import '../../../shared/sql_functions.dart';
import '../../loading.dart';

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
  late Future<List<String>> countryStateFuture;

  bool loading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    countryStateFuture = getCountryState(int.parse(widget.registry.lada!));
    countryStateFuture.then((List<String> countryState){
      if(countryState.isNotEmpty){
        setState(() {
          widget.registry.country = countryState[1];
          widget.registry.state = countryState[0];
          loading = false;
        });
      } else{
        Navigator.of(context).pop();
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
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: "País",
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color_1)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                        ),
                        child: Text(widget.registry.country!, textAlign: TextAlign.center)
                      )
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      flex: 5,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: "Estado",
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color_1)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                        ),
                        child: Text(widget.registry.state!, textAlign: TextAlign.center)
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