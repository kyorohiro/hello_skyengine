import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui' as sky;
import 'package:flutter/services.dart';
import 'package:mojo/core.dart' as core;
import 'package:mojo_services/sensors/sensors.mojom.dart';

main() async {
  print("######====================####s##");
  SensorServiceProxy sensor = new SensorServiceProxy.unbound();
  shell.requestService("h", sensor);

  SensorListenerStub stub = new SensorListenerStub.unbound();
  stub.impl = new MySensorListener();
  sensor.ptr.addListener(SensorType.GRAVITY, stub);
  print("######====================###s###");
}

class MySensorListener extends SensorListener {
  void onAccuracyChanged(int accuracy) {
    print("accuracy: ${accuracy}");
  }

  void onSensorChanged(SensorData data) {
    print("data: ${data.accuracy} ${data.values}");
  }
}
