import 'package:flutter/material.dart';
import '../shared/constants.dart';

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
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            getIconoPorTexto(widget.sensorName, widget.value),
            color: const Color(0xFF767674),
            size: 30.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          widget.value.toString(),
          style: const TextStyle(
            color: Color(0xFF0f1b35),
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
