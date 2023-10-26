import 'package:flutter/material.dart';
import '../services/sensor_monitor.dart';

//----------------------------------------------------------------------
//Futuro display de sensores en tiempo real. Ya funciona en feo
//----------------------------------------------------------------------


class SensorDisplay extends StatefulWidget {
  // ignore: use_super_parameters
  const SensorDisplay({Key? key}) : super(key: key);

  @override
  SensorDisplayState createState() => SensorDisplayState();

}

class SensorDisplayState extends State<SensorDisplay> {
  final SensorMonitor monitor = SensorMonitor();

  @override
  void initState() {
    super.initState();
    monitor.initialize();
  }

  @override
  void dispose() {
    monitor.dispose();  // Llamar a dispose en el SensorMonitor cuando este widget se deshaga
    super.dispose();
    print("cerrado display");
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, String>>(
      stream: monitor.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Text('No data');
        }
        
        final sensorData = snapshot.data!;
        return ListView(
          children: sensorData.entries.map((entry) {
            final sensorName = entry.key;
            final value = entry.value;
            return ListTile(
              title: Text('$sensorName: $value'),
            );
          }).toList(),
        );
      },
    );
  }
}