# Dart:io File Path

https://github.com/kyorohiro/hello_skyengine/tree/master/dartio_service_path

![](screen.png)

```
// flutter: ">=0.0.15"
// following code is checked in 2015/10/31
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

main() async {
  PathServiceProxy pathServiceProxy = new PathServiceProxy.unbound();
  shell.requestService("dummy", pathServiceProxy);
  StringBuffer buffer = new StringBuffer();
  buffer.write("Directory.current = ${Directory.current} \n");
  buffer.write("Directory.systemTemp = ${Directory.systemTemp} \n");
  buffer.write("Directory.systemTemp = ${new Directory("./").absolute} \n");
  buffer.write("PathService.getAppDataDir = ${await pathServiceProxy.ptr.getAppDataDir()} \n");
  buffer.write("PathService.getCacheDir = ${await pathServiceProxy.ptr.getCacheDir()} \n");
  buffer.write("PathService.getFileDir = ${await pathServiceProxy.ptr.getFilesDir()} \n");
  pathServiceProxy.close();
  Text t = new Text("${buffer.toString()}");
  Center c = new Center(child: t);
  runApp(c);
}
```
