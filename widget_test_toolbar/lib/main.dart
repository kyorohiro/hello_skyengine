import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as sky;
import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';

class MyToolBar extends StatelessComponent {
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      padding: const EdgeDims.symmetric(horizontal: 8.0),
      child: new Material(
        child: new Row([
          new NetworkImage(src: 'icon.jpeg', width: 25.0, height: 25.0),
          new Flexible(child: new Text('My awesome toolbar')),
          new NetworkImage(src: 'icon.jpeg', width: 25.0, height: 25.0),
        ])
      )
    );
  }
}
/*
void main() {
//  runApp(new Center(child: new MyToolBar()));
  runApp(new Row([
    new NetworkImage(src: 'icon.jpeg', width: 25.0, height: 25.0),
    new Flexible(child: new Text('My awesome toolbar')),
    new NetworkImage(src: 'icon.jpeg', width: 25.0, height: 25.0),
  ]));
}*/

class TutorialHome extends StatelessComponent {
  Widget build(BuildContext context) {
    return new Center(child: new MyToolBar());
  }
}
void main() {
  runApp(new MaterialApp(
    title: 'Tutorial app',
    routes: {
      '/': (RouteArguments args) => new TutorialHome()
    }
  ));
}
