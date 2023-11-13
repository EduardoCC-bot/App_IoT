import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:proyectoiot/shared/widget_functions.dart';

//------------------------------------------------------------
//Clase encargada de la lectura en tiempo real de los sensores 
//------------------------------------------------------------

class SensorMonitor {
  String? housePath;
  final DatabaseReference reference = FirebaseDatabase.instance.ref();
  final Map<String, num> _sensorData = <String, num>{};
  StreamController<Map<String, num>>? _controller;
  final List<StreamSubscription<DatabaseEvent>> _subscriptions = [];  // Lista para almacenar las suscripciones

 static final SensorMonitor _singleton = SensorMonitor._internal();
  
  factory SensorMonitor() {
    return _singleton;
  }
  
  SensorMonitor._internal();

  void initialize() {
    _controller = StreamController();
    if (housePath != null) {
      _initializeListeners();
    }
  }

  void configureCasaPath(String casaPath) {
    housePath = replaceSpaces(casaPath);
    if (_controller != null) {
      _initializeListeners();
    }
  }

  void _initializeListeners() {

    final List<String> sensorPaths = [
      'Ultima_temperatura',
      'Ultima_gas',
      'Ultima_luz',
      'Ultima_humedad'   
    ];

    for (final path in sensorPaths) {
      StreamSubscription<DatabaseEvent> subscription = reference.child("$housePath/$path").onValue.listen((event) {
          final sensorName = path.split('_').last;
          final value = num.tryParse(event.snapshot.child(sensorName).value.toString()) ?? 0.0;
          _sensorData[sensorName] = value;
          _controller!.add(Map<String, num>.from(_sensorData));  // Emitir una copia del mapa
      });
      _subscriptions.add(subscription);
    }
  }

  void dispose() {
    for (var subscription in _subscriptions) {  // Iterar sobre las suscripciones y cancelar cada una
      subscription.cancel();
    }
    _controller!.close();
    print("cerrado monitor");
  }

  Stream<Map<String, num>> get stream => _controller!.stream;

}