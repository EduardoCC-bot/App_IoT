import 'package:flutter/material.dart';
import 'package:proyectoiot/screens/loading.dart';
import 'package:proyectoiot/shared/sql_functions.dart';
import 'package:proyectoiot/special_widgets/add_device.dart';
import 'package:proyectoiot/special_widgets/dropdown_button.dart';
//import 'package:proyectoiot/shared/constants.dart';

// ignore: must_be_immutable
class AddSomething extends StatefulWidget {
  int pkCasa;
  String houseName;
  AddSomething({super.key, required this.pkCasa, required this.houseName});

  @override
  State<AddSomething> createState() => _AddSomethingState();
}

class _AddSomethingState extends State<AddSomething> {
  
  bool loading = true;

  late Map<String,int> areasMap;
  List<String>? areas=[];
  //nombre del Area
  String? selectedArea;
  //clave del area
  int? pkArea;

  late Map<String,int> devicesTypesMap;
  List<String>? devicesTypes=[];
  String? selectedDevice;
  int? pkDevice;

  void initAreasMap() async {
    areasMap = await getAreas(widget.pkCasa);
    setState(() {
    areas = areasMap.keys.toList();
    if(areas!.isNotEmpty) {
      selectedArea = areas!.first;
      pkArea = (areas!.isNotEmpty ? areasMap[areas!.first] : null);
    }
   });
  }

  void initDevicesTypes() async {
    devicesTypesMap = await getDevicesTypes();
    setState(() {
    devicesTypes = devicesTypesMap.keys.toList();
    if(devicesTypes!.isNotEmpty) {
      selectedDevice = devicesTypes!.first;
      pkDevice = (devicesTypes!.isNotEmpty ? devicesTypesMap[devicesTypes!.first] : null);
      loading = false;
    }
   });
  }

  @override
  void initState() {
    super.initState();
    initAreasMap();
    initDevicesTypes();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : AlertDialog(
      title: const Text('Selecciona las opciones'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: dropDownOptions(
              (newValue) {
                setState(() {
                  selectedArea = newValue; // Actualizar el valor seleccionado
                  pkArea = (areas!.isNotEmpty && newValue != null ? areasMap[newValue] : null); // Actualizar el valor asociado del mapa
                });
              },
              areas!,
              selectedArea,
              "Área" // Etiqueta para el dropdown
            )
          ),
          const Padding(padding: EdgeInsets.all(12.0)),
 //--------------------------------------------------------------------------
          Flexible(
            flex: 1,
            child: dropDownOptions(
              (newValue) {
                setState(() {
                  selectedDevice = newValue; // Actualizar el valor seleccionado
                  pkDevice = (devicesTypes!.isNotEmpty && newValue != null ? devicesTypesMap[newValue] : null); // Actualizar el valor asociado del mapa
                });
              },
              devicesTypes!,
              selectedDevice,
              "Tipo de dispositivo" // Etiqueta para el dropdown
            )
          ),
        ],
//--------------------------------------------------------------------------              
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('Siguiente'),
          onPressed: () {
           Navigator.pop(context);
           showDialog(
              context: context,
              builder: (BuildContext context) {
              return AddDevice(
                houseName: widget.houseName,
                pkArea: pkArea!,
                pkDeviceType: pkDevice!,
                selectedDevice: selectedDevice!,
                areaName: selectedArea!
                );
              },
            ); 
          },
        ),
      ],
    );
  }
}




