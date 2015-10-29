import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(new MaterialApp(
      title: 'Cards',
      routes: <String, RouteBuilder>{
        '/': (RouteArguments args) {
          return new AAA();
        },
      }));
}

class AAA extends StatefulComponent {
  State createState() {
    return new AaaState();
  }
}

class AaaState extends State<AAA> {
  Widget build(BuildContext context) {
    Widget body = new Center(child: new Text("body"));
    Widget toolBar = new ToolBar(
        left: new IconButton(icon: "navigation/menu", onPressed: showMyDrawer),
        center: new Text("center"));
    Scaffold s = new Scaffold(toolBar: toolBar, body: body);
    return s;
  }

  void showMyDrawer() {
    Block block = new Block(<Widget>[
      createMyHeader("Start"),
      createMyItem("---s 0001"),
      createMyItem("---s 0002"),
      createMyHeader("Next"),
      createMyItem("---n 0001"),
      createMyItem("---n 0002")
    ]);

    showDrawer(context: this.context, child: block, level: 3);
  }

  DrawerHeader createMyHeader(String message) {
    return new DrawerHeader(child: new Text("${message}"));
  }

  DrawerItem createMyItem(String message) {
    return new DrawerItem(onPressed: () {
      print("pressed ${message}");
    }, child: new Text("${message}"));
  }
}
