import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';

typedef OnDropdownChanged = void Function(String?);

InputDecorator dropDownOptions(OnDropdownChanged onSelected, List<String> options, String currentValue, String label){
    return InputDecorator(
    decoration: InputDecoration(
      labelText: label,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: color_1), // Color del borde cuando el campo está habilitado
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5), //relleno dentro del borde
      ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: currentValue,
        dropdownColor: color_5,
        isExpanded: true,
        onChanged: onSelected,
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center( // Envuelve el Text en un widget Center
              child: Text(
                value,
                textAlign: TextAlign.center, // Centra el texto horizontalmente
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

