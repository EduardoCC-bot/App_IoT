import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_info.dart';
import '../services/sensor_monitor.dart';
import 'sensor_icon.dart';

//----------------------------------------------------------------------
//Display de todos los sensores en tiempo real
//----------------------------------------------------------------------


class SensorDisplay extends StatefulWidget {
  // ignore: use_super_parameters
  const SensorDisplay({Key? key}) : super(key: key);

  @override
  SensorDisplayState createState() => SensorDisplayState();

}

class SensorDisplayState extends State<SensorDisplay> {
  late final SensorMonitor monitor;

  @override
  void initState() {
    super.initState();
    initMonitor();
  }

  void initMonitor() {
    UserInfo userInfo = Provider.of<UserInfo>(context, listen: false);
    monitor = SensorMonitor();
    monitor.configureCasaPath(userInfo.casa!);
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
    return StreamBuilder<Map<String, num>>(
      stream: monitor.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Text('Cargando...');
        }

        final sensorData = snapshot.data!;

        return SizedBox (
          height: 100,
          child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sensorData.keys.length,
          itemBuilder: (context, index) {
            final key = sensorData.keys.elementAt(index);
            final value = sensorData[key];
            
            // Pasando el valor al IconoTextoWidget
            return SizedBox(
              width: 94,
              child: SensorIconText(sensorName: key, value: value!));
            },
          )
        );
      },
    );
  }
}

