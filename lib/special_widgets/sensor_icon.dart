import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../shared/widget_functions.dart';

//----------------------------------------------------------------------
//Widget individual por cada sensor. Contiene un icono y su valor en tiempo real
//----------------------------------------------------------------------


// ignore: must_be_immutable
class SensorIconText extends StatefulWidget {
  String sensorName;
  num value;
  SensorIconText({super.key, required this.sensorName, required this.value});

  @override
  // ignore: no_logic_in_create_state
  SensorIconTextState createState() => SensorIconTextState();
}

class SensorIconTextState extends State<SensorIconText> {
  SensorIconTextState();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: color_4,//Colors.grey[200],
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            getIconForValor(widget.sensorName, widget.value),
            color: color_0,
            size: 30.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          getValueWithEscale(widget.sensorName, widget.value),
          style: const TextStyle(
            color: color_0,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
