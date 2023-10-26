import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class SensorMonitor {
  final DatabaseReference reference = FirebaseDatabase.instance.ref();
  final Map<String, String> _sensorData = <String, String>{};
  StreamController<Map<String, String>>? _controller;
  final List<StreamSubscription<DatabaseEvent>> _subscriptions = [];  // Lista para almacenar las suscripciones

  static final SensorMonitor _singleton = SensorMonitor._internal();
  
  factory SensorMonitor() {
    return _singleton;
  }
  
  SensorMonitor._internal() {
    _initializeListeners();
  }

  void initialize() {
    _controller = StreamController();
    _initializeListeners();
  }

  void _initializeListeners() {

    final List<String> sensorPaths = [
      'Ultima_temperatura',
      'Ultima_gas',
      'Ultima_luz',
      'Ultima_humedad'   
    ];

    for (final path in sensorPaths) {
      StreamSubscription<DatabaseEvent> subscription = reference.child(path).onValue.listen((event) {
          final value = event.snapshot.value.toString();
          final sensorName = path.split('_').last;
          _sensorData[sensorName] = value;
          _controller!.add(Map<String, String>.from(_sensorData));  // Emitir una copia del mapa
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

  Stream<Map<String, String>> get stream => _controller!.stream;

}