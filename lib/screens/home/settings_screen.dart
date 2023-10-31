import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/images_icons/settings_icon.dart';
import 'package:proyectoiot/special_widgets/switch.dart';
//------------------------------------------------------------
//Pantalla de configuraciones
//------------------------------------------------------------


//valores que obtendremos al hacer la conexion con la base de datos
String nombre = '';
String apellidoP = '';
String apellidoM = '';
int edad = 0;
bool status = false;


class Settings extends StatelessWidget{
  const Settings({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
         mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: [
            const SizedBox(height: 20),
            settingsIcon,
            ElevatedButton(onPressed: () {
                print('Detalles de perfil');
              }, 
              child: const ListTile(
                leading: Icon(Icons.person_2, color: color_11),
                title: Text(
                'Detalles de perfil',
                ),
              )
            ),
            const SizedBox(height: 10),

            ElevatedButton(onPressed: () {
                print('Detalles de casa');
              }, 
              child: const ListTile(
                leading: Icon(Icons.other_houses, color: color_11),
                title: Text(
                'Detalles de casa',
                ),
              )
            ),
          const SizedBox(height: 10),
          Container(
              color: Colors.blue,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.dark_mode, color: color_11,) ,
                    Text("Modo obscuro"),
                  ] 
                ),
                SwitchDevices(
                  isSwitched: true, // Proporciona el valor inicial del switch
                  onChanged: (bool newValue) {
                    // Maneja el cambio de estado del switch aquí
                    print('Nuevo estado del Switch: $newValue');
                  },
                ),
              ],
            ),
          ),
        ],

    );
  }
}