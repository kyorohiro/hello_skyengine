import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

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
  //
  // 2015 12/13 icon.jpeg is error
//  AssetImage i = new AssetImage(name:"assets/icon.jpeg",bundle:rootBundle);
  AssetImage i = new AssetImage(name:"assets/a.png",bundle:rootBundle);
//  NetworkImage i = new NetworkImage(src: "./icon.jpeg");

  FlexJustifyContent justifyContent = FlexJustifyContent.spaceBetween;
  FlexAlignItems alignItems = FlexAlignItems.center;
  TextBaseline textBaseline = TextBaseline.ideographic;
  Row r = new Row([c, t, i],
      justifyContent: justifyContent,
      alignItems: alignItems,
      textBaseline: textBaseline);
  runApp(new Column([c, t, i, r],
      justifyContent: justifyContent,
      alignItems: alignItems,
      textBaseline: textBaseline));
}
