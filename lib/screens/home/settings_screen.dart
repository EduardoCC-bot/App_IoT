import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/images_icons/settings_icon.dart';
import 'package:proyectoiot/special_widgets/switch.dart';
import 'package:proyectoiot/screens/settings/profile_screen.dart';
import 'package:proyectoiot/screens/settings/houseDetails_screen.dart';
//------------------------------------------------------------
//Pantalla de configuraciones
//------------------------------------------------------------



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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => profile_screen()));
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => houseDetails_screen()));
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
            child: ListTile(
              leading: const Icon(Icons.dark_mode_outlined, color: color_11),
                title: const Text(
                'Modo Obscuro',
                ),
                trailing: SwitchDevices(
                  isSwitched: true, // Proporciona el valor inicial del switch
                  onChanged: (bool newValue) {
                    // Maneja el cambio de estado del switch aquí
                    print('Nuevo estado del Switch: $newValue'); 
                  },
                ),
            ),
          ),
        ],

    );
  }
}