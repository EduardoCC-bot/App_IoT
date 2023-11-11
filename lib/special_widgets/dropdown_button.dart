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
      contentPadding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: currentValue,
        enableFeedback: true,
        dropdownColor: color_5,
        isExpanded: true,
        onChanged: onSelected,
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(
                "+$value",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}
/*import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';

typedef OnDropdownChanged = void Function(String?);

Widget dropDownOptions(OnDropdownChanged onSelected, List<String> options, String? currentValue, String label) {
  List<DropdownMenuEntry<String>> menuEntries = options.map((String value) {
  return DropdownMenuEntry<String>(
    label: "+$value",
    value: value,
  );
}).toList();

  return InputDecorator(
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: color_1)),
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      ),
      child: DropdownMenu<String>(
      initialSelection: menuEntries.first.value,
      leadingIcon: const Icon(Icons.search),
      enableSearch: true,
      enableFilter: true,
      label: Text(label),
      inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
          outlineBorder: BorderSide(color: color_1),
        ),
      dropdownMenuEntries: menuEntries,
      onSelected: onSelected,
    )
  );
}*/
