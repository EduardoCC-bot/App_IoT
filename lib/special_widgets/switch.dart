import 'package:flutter/material.dart';
import 'package:proyectoiot/shared/constants.dart';

//----------------------------------------------------------------------
// Widget switch. Utilizado para controlar los dispositivos en tiempo real
//----------------------------------------------------------------------


class SwitchDevices extends StatefulWidget {
  final bool isSwitched;
  final ValueChanged<bool> onChanged;
  const SwitchDevices({super.key, required this.isSwitched, required this.onChanged});

  @override
  // ignore: library_private_types_in_public_api
  _SwitchDevicesState createState() => _SwitchDevicesState();
}

class _SwitchDevicesState extends State<SwitchDevices> {
  late bool _isSwitched;

  @override
  void initState() {
    super.initState();
    _isSwitched = widget.isSwitched;
  }

  @override
  void didUpdateWidget(covariant SwitchDevices oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSwitched != widget.isSwitched) {
      _isSwitched = widget.isSwitched;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isSwitched,
      activeColor: color_11,
      activeTrackColor: color_13,
      inactiveThumbColor: color_2,
      inactiveTrackColor: color_4,
      onChanged: (value) {
        setState(() {
          _isSwitched = value;
        });
        widget.onChanged(_isSwitched);  // Notifica a la clase padre sobre el cambio.
        print(_isSwitched);  
      },
    );
  }
}