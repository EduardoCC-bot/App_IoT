import 'package:flutter/material.dart';
import 'package:proyectoiot/services/auth.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/images_icons/register_icon.dart';
import 'package:proyectoiot/shared/functions.dart';
import 'package:proyectoiot/special_widgets/dropdown_button.dart';

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
  List<String> list = <String>['One', 'Two', 'Three', 'Four']; 
  String dropdownValue = '';
  bool loading = false;

  //estado de campo de texto
  String email = '';
  String password = '';
  String name = '';
  String apm = '';
  String app = '';
  int age = 0;
  String error = '';
  int telephone = 0;

  @override
  void initState() {
    super.initState();
    dropdownValue = list.first; // Ahora puedes acceder a 'list' porque estamos en un método y no en el inicializador
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlanco,
      appBar: AppBar(
        backgroundColor: color_1,
        elevation: 5.0,
        title: const Text('Registrarse'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: colorBlanco),
            label : const Text(
              'Acceder',
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
                registerIcon,
//-------------------------------------------------------------------------------------------------------------------                
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children:[
                    Flexible(
                      flex: 4,
                      child: formBox('Nombre', 'Complete el campo', context,(val) => setState(() => name = val)),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                        flex: 1,
                        child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Edad'),
                        keyboardType: TextInputType.number,
                        validator: (val){
                            if (val!.isEmpty) {
                              return 'Complete el campo';
                            }
                            if (!isNumeric(val)) {
                              return 'Solo números';
                            }
                            return null; // Devuelve null si no hay errores de validación
                        },
                        onChanged: (val) {
                          setState(() {
                            try {
                              age = int.parse(val);
                            } catch (e) {
                              print('Ingresa solo números');
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
                      child: formBox('Apellido materno', 'Complete el campo', context, (val) => setState(() => apm = val)),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      flex: 1,
                      child: formBox('Apellido paterno', 'Complete el campo', context,(val) => setState(() => app = val)),
                    ),
                  ],
                ),
//-------------------------------------------------------------------------------------------------------------------                
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 2,
                      child: dropDownOptions((String? value) => setState(() => dropdownValue = value!), list,dropdownValue, 'Lada')
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                        flex: 5,
                        child: TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Teléfono'),
                        keyboardType: TextInputType.number,
                        validator: (val){
                            if (val!.isEmpty) {
                              return 'Complete el campo';
                            }
                            if (!isNumeric(val)) {
                              return 'Solo números';
                            }
                            return null; // Devuelve null si no hay errores de validación
                        },
                        onChanged: (val) {
                          setState(() {
                            try {
                              telephone = int.parse(val);
                            } catch (e) {
                              print('Ingresa solo números');
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
                          child: formBox('Correo electrónico', 'Complete el campo', context, (val) => setState(() => email = val)),
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
                        setState(() => password = val);
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
                    'Registrarse',
                    style: TextStyle(color: colorBlanco),
                    ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Ingrese un correo eléctronico válido';
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
        )
      ),
    );
  }
}

bool isNumeric(String? value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}
