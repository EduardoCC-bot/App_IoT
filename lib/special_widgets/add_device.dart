import 'package:flutter/material.dart';
//import 'package:proyectoiot/shared/constants.dart';
//import '../shared/sql_functions.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {

  late Future<List<String>> areas;
  late Future<List<String>> devices;
  String? selectedArea;
  String? selectedDevice;
  String? errorArea;
  String? errorDevice;

  void onAreaSelected(dynamic area) {
    // Actualiza el estado y maneja los errores
    setState(() {
      selectedArea = area;
      errorArea = (area == null || area.isEmpty) ? 'Seleccione un área' : null;
    });
  }

  void onDeviceSelected(dynamic device) {
    // Actualiza el estado y maneja los errores
    setState(() {
      selectedDevice = device;
      errorDevice = (device == null || device.isEmpty) ? 'Seleccione un dispositivo' : null;
    });
  }

  void verifySelection() {
    // Verifica la selección y maneja los errores
    if (selectedArea == null || selectedArea!.isEmpty) {
      setState(() {
        errorArea = 'Seleccione un área';
      });
    }
    if (selectedDevice == null || selectedDevice!.isEmpty) {
      setState(() {
        errorDevice = 'Seleccione un dispositivo';
      });
    }

    if (errorArea == null && errorDevice == null) {
      // Todo seleccionado correctamente
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  void initState() {
    super.initState();
   /*areas = getLada();
    areas.then((List<int> ladasList){
      if(ladasList.isNotEmpty){
        setState(() {
          registry.lada = ladasList.first.toString();
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecciona las opciones'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedArea,
              hint: const Text('Área'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedArea = newValue;
                  errorArea = null;
                });
              },
              items: <String>['Opción 1', 'Opción 2', 'Opción 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          if (errorArea != null)
              Text(errorArea!, style: const TextStyle(color: Colors.red)),
 //--------------------------------------------------------------------------
          Flexible(
            flex: 1,
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedDevice,
              hint: const Text('Dispositivo'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDevice = newValue;
                  errorDevice = null;
                });
              },
              items: <String>['Opción A', 'Opción B', 'Opción C']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          if (errorDevice  != null)
              Text(errorDevice !, style: const TextStyle(color: Colors.red)),
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
          child: const Text('Aceptar'),
          onPressed: () {
            verifySelection();
          },
        ),
      ],
    );
  }
}




