import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyectoiot/screens/loading.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/shared/sql_functions.dart';
import 'package:proyectoiot/special_widgets/dropdown_button.dart';

import '../shared/widget_functions.dart';

class AddDevice extends StatefulWidget {
  final int pkArea;
  final int pkDeviceType;
  final String selectedDevice;
  final String houseName;
  final String areaName;
  const AddDevice({super.key, required this.pkArea, required this.pkDeviceType, required this.selectedDevice, required this.houseName, required this.areaName});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool? validName = true;


  late Map<String,int> devicesFromTypesMap;
  List<String>? devicesFromTypes = [];
  String? selectedDeviceFromType;
  int? pkDeviceFromType;

  String? deviceName;

  void initDevicesFromTypes() async {
    devicesFromTypesMap = await getDevicesFromType(widget.selectedDevice);
    setState(() {
      devicesFromTypes = devicesFromTypesMap.keys.toList();
      if(devicesFromTypes!.isNotEmpty) {
        selectedDeviceFromType = devicesFromTypes!.first;
        pkDeviceFromType = devicesFromTypesMap[selectedDeviceFromType];
      }
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initDevicesFromTypes();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : AlertDialog(
      title: const Text('Añade tu dispositivo', style: TextStyle(color: color_0),),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: formBox('Nombre del dispositivo', 'Complete el campo', context, (val) => deviceName = val),
            ),

            if (validName! == false) // Condición para mostrar el mensaje
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text("Ese nombre ya ha sido ocupado", textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontSize: 12)),
            ),
            const Padding(padding: EdgeInsets.all(12.0)),


            Flexible(
              flex: 1,
              child: dropDownOptions(
                (newValue) {
                  setState(() {
                    selectedDeviceFromType = newValue;
                    pkDeviceFromType = devicesFromTypesMap[newValue];
                  });
                },
                devicesFromTypes!,
                selectedDeviceFromType,
                "Tipo de ${widget.selectedDevice}"
              )
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                setState(() => loading = true);
                if((await verifyDevieUniqueName(deviceName!, widget.pkArea))== 0){
                  await addDevice(deviceName!, widget.pkArea, pkDeviceFromType!, widget.pkDeviceType, widget.selectedDevice);
                  await insertDeviceNoSQL(widget.houseName, widget.areaName, deviceName!, widget.selectedDevice);
                  setState(() => loading = false);
                  if (mounted) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                } else {
                  setState(() => validName = false);
                  setState(() => loading = false);
                }
              } catch (error) {
                // ignore: avoid_print
                print('Ocurrió un error: $error');
              }
            }
          },
        ),
      ],
    );
  }

  Future<void> insertDeviceNoSQL(String house, String areaName, String deviceName, String deviceType) async {
    String housePath = replaceSpaces(house);
    String areaPath = replaceSpaces(areaName);
    String devicePath = replaceSpaces(deviceName);
    DatabaseReference ref = FirebaseDatabase.instance.ref("$housePath/Espacios/$areaPath/Dispositivos/$devicePath");
    await ref.update({
      "dispositivo": deviceType,
      "estado": false,
      "version": 1
    });
  }
}