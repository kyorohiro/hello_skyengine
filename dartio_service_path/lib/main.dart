import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

main() async {
  PathServiceProxy pathServiceProxy = new PathServiceProxy.unbound();
  shell.connectToService("dummy", pathServiceProxy);
  StringBuffer buffer = new StringBuffer();
  buffer.write("Directory.current = ${Directory.current} \n");
  buffer.write("Directory.systemTemp = ${Directory.systemTemp} \n");
  buffer.write("Directory('./') = ${new Directory("./").absolute} \n");
  buffer.write("PathService.getAppDataDir = ${await pathServiceProxy.ptr.getAppDataDir()} \n");
  buffer.write("PathService.getCacheDir = ${await pathServiceProxy.ptr.getCacheDir()} \n");
  buffer.write("PathService.getFileDir = ${await pathServiceProxy.ptr.getFilesDir()} \n");
  pathServiceProxy.close();
  Text t = new Text("${buffer.toString()}");
  Center c = new Center(child: t);
  runApp(c);
}
