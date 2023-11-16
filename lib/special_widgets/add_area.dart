import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyectoiot/models/house_info.dart';
import 'package:proyectoiot/screens/loading.dart';
import 'package:proyectoiot/shared/constants.dart';
import 'package:proyectoiot/shared/sql_functions.dart';
import 'package:proyectoiot/special_widgets/dropdown_button.dart';

import '../shared/widget_functions.dart';

class AddArea extends StatefulWidget {
  final int pkHouse;
  final String houseName;
  final HouseInfo houseInfo;

  const AddArea({super.key, required this.pkHouse, required this.houseName, required this.houseInfo});

  @override
  State<AddArea> createState() => _AddAreaState();
}

class _AddAreaState extends State<AddArea> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool? validName = true;

  late Map<String,int> areaTypesMap;
  List<String>? areaTypes = [];
  String? selectedAreaType;
  int? pkOfAreaType;

  String? areaName;

  void initAreasTypes() async {
    areaTypesMap = await getAreasTypes();
    setState(() {
      areaTypes = areaTypesMap.keys.toList();
      if(areaTypes!.isNotEmpty) {
        selectedAreaType = areaTypes!.first;
        pkOfAreaType = areaTypesMap[selectedAreaType];
      }
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initAreasTypes();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : AlertDialog(
      title: const Text('Crea tu área', style: TextStyle(color: color_0),),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: formBox('Nombre de tu nueva área', 'Complete el campo', context, (val) => areaName = val),
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
                    selectedAreaType = newValue;
                    pkOfAreaType = areaTypesMap[newValue];
                  });
                },
                areaTypes!,
                selectedAreaType,
                "Tipo de área"
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
                if((await verifyAreaUniqueName(areaName!, widget.pkHouse))== 0){
                  await addArea(areaName!, widget.pkHouse,pkOfAreaType!);
                  await insertAreaNoSQL(widget.houseName,areaName!,selectedAreaType!);
                  widget.houseInfo.obtenerEspacios(replaceSpaces(widget.houseName));
                  setState(() => loading = false);
                  if (mounted) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                } else{
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

  Future<void> insertAreaNoSQL(String house, String areaName, String areType) async {
    String housePath = replaceSpaces(house);
    String areaPath = replaceSpaces(areaName);
    DatabaseReference ref = FirebaseDatabase.instance.ref("$housePath/Espacios/$areaPath");
    await ref.update({
      "descripcion": areType,
      "version": 1
    });
    ref = FirebaseDatabase.instance.ref("$housePath/Nombre_espacios");
    await ref.update({
      areaPath: areType,
    });
  }
}