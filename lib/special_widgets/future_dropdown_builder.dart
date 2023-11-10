import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proyectoiot/special_widgets/dropdown_button.dart';

import '../shared/constants.dart';

//definición de los tipos  DropdownValueFormatter<T> y OnDropdownChanged<T?> como funciones

typedef DropdownValueFormatter<T> = String Function(T value);
typedef OnDropdownChanged<T> = void Function(T value);

class FutureDropdownBuilder<T> extends StatelessWidget {
  final Future<List<T>> future;   //Lista de datos recibida
  final DropdownValueFormatter<T> valueFormatter;  //operación que convierte los datos a String
  final OnDropdownChanged<T?> onSelected;   //al seleccionar dato
  final T? initialValue;    //dato inicial
  final String label;       //etiqueta para el dropdownbutton

  const FutureDropdownBuilder({
    super.key,
    required this.future,
    required this.valueFormatter,
    required this.onSelected,
    this.initialValue,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitChasingDots(color:  color_0,size: 20.0);

        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');

        } else if (snapshot.hasData && snapshot.data != null) {
          List<String> stringOptions = snapshot.data!.map((T value) => valueFormatter(value)).toList();
          String? currentValue = (initialValue != null ? valueFormatter(initialValue!) : null);
          return dropDownOptions(
            (String? newValue) {
              // Encuentra el objeto original basado en el valor de la cadena.
              T? selectedValue = snapshot.data!.firstWhere(
                (item) => valueFormatter(item) == newValue,
              );
              onSelected(selectedValue);
            },
            stringOptions,
            currentValue,
            label,
          );
        } else {
          return const Text('No hay datos disponibles');
        }
      },
    );
  }
}