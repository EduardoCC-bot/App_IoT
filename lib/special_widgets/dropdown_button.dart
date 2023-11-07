import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';

typedef OnDropdownChanged = void Function(String?);

Widget dropDownOptions(OnDropdownChanged onSelected,List<String> options,String? currentValue,String label) {
  return InputDecorator(
    decoration: InputDecoration(
      labelText: label,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: color_1),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
            child: Center(
              child: Text(
                value,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}

