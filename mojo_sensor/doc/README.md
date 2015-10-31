# Sensor Test

https://github.com/kyorohiro/hello_skyengine/tree/master/mojo_sensor

```
// flutter: ">=0.0.15"
// following code is checked in 2015/10/31
import 'package:flutter/services.dart';
import 'package:mojo_services/sensors/sensors.mojom.dart';

main() async {
  print("######====================####s##");
  SensorServiceProxy sensor = new SensorServiceProxy.unbound();
  shell.connectToService("h", sensor);

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
```
