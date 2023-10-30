import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SwitchDevices extends StatefulWidget {
  SwitchDevices({super.key, required this.isSwitched});
  bool isSwitched;

  @override
  // ignore: library_private_types_in_public_api
  _SwitchDevicesState createState() => _SwitchDevicesState();
}

class _SwitchDevicesState extends State<SwitchDevices> {


  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.isSwitched,
      onChanged: (value) {
        setState(() {
          widget.isSwitched = value;
          print(widget.isSwitched);  // Puedes imprimir o realizar alguna acción dependiendo del estado.
        });
      },
    );
  }
}