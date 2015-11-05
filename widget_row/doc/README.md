# Widget ROW

https://github.com/kyorohiro/hello_skyengine/tree/master/widget_row

![](screen.png)

```
// following code is checked in 2015/11/05
// but faield to draw image!!
//
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as sky;
import 'dart:math' as math;
import 'dart:async';

main() async {
  double width = 100.0;
  double height = 100.0;
  Container c = new Container(
      child: new Text("Container"),
      decoration: new BoxDecoration(
          backgroundColor: new Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa)),
      width: width,
      height: height);
  Text t = new Text("Text");
  NetworkImage i = new NetworkImage(src: "./icon.jpeg");

  FlexJustifyContent justifyContent = FlexJustifyContent.spaceBetween;
  FlexAlignItems alignItems = FlexAlignItems.center;
  TextBaseline textBaseline = TextBaseline.ideographic;
  runApp(new Row([c, t, i],
      justifyContent: justifyContent,
      alignItems: alignItems,
      textBaseline: textBaseline));
}

```
