import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectoiot/models/house_info.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/images_icons/settings_icon.dart';
import 'package:proyectoiot/special_widgets/switch.dart';
import 'package:proyectoiot/screens/settings/profile_screen.dart';
import 'package:proyectoiot/screens/settings/house_details_screen.dart';

import '../../models/user_info.dart';
//------------------------------------------------------------
//Pantalla de configuraciones
//------------------------------------------------------------

class Settings extends StatefulWidget{
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool status = false;
  @override
  Widget build(BuildContext context){
    UserInfo userInfo = Provider.of<UserInfo>(context, listen: false);
    HouseInfo houseInfo = Provider.of<HouseInfo>(context, listen: false);
    print("User Info: " + userInfo.toString());
    print("house Info: " + houseInfo.toString());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center, 
    children: [
        const SizedBox(height: 30),
        settingsIcon,
        const SizedBox(height: 15),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.person_2, color: color_11),
            title: const Text('Detalles de perfil', style:  TextStyle(color: color_0)),
            tileColor: color_5,
            onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(user: userInfo)));
            },
        ),
        const Divider(),
        ListTile(
            leading: const Icon(Icons.other_houses, color: color_11),
            title: const Text('Detalles de casa', style:  TextStyle(color: color_0)),
            tileColor: color_5,
            onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => HouseDetailsScreen(house: houseInfo, user: userInfo)));
            },
        ), 
        const Divider(),
        ListTile(
          leading: const Icon(Icons.dark_mode, color: color_11),
          title: const Text('Modo oscuro', style:  TextStyle(color: color_0)),
          tileColor: color_5,
          onTap: () {setState(() { status = !status; print('Nuevo estado del Switch: $status'); });},
          trailing: SwitchDevices(
            isSwitched: status, // Proporciona el valor inicial del switch
            onChanged:(value) {
              status = value;
            },
          ),
        ),
        const Divider(),
      ],
    );
  }
}