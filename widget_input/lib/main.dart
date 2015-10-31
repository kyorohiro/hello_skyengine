import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

void main() {
  // 2015/10/26 if use IconButton's icon option, need MatrialApp?
  runApp(new MaterialApp(
      title: "Drawer",
      routes: <String, RouteBuilder>{
        '/': (RouteArguments args) {
          return new DrawerTest();
        },
      }));
}

class DrawerTest extends StatefulComponent {
  State createState() {
    return new DrawerTestState();
  }
}

class DrawerTestState extends State<DrawerTest> {
  Widget build(BuildContext context) {
    return newInputWidget();
  }
}

Widget newInputWidget() {
  double width = 100.0;
  double height = 100.0;
  TextBaseline textBaseline = TextBaseline.ideographic;
  final String initialValue = "<init>";
  final KeyboardType keyboardType = KeyboardType.TEXT;
  final String placeholder = "placegolder";
  Input input = new Input(
    initialValue:initialValue,
    keyboardType:keyboardType,
    placeholder:placeholder,
    onChanged:(String v){print("changed: ${v}");},
    onSubmitted:(String v){print("submitted: ${v}");}
  );
  runApp(new Center(child:input));
}
